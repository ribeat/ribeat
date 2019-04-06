//
//  RibServing.swift
//  Ribeat
//
//  Created by Alin Brindusescu on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import Swifter

import CoreData

class RibServing {
    let server: HttpServer
    let persistentContainer: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        persistentContainer = container
        server = HttpServer()
        server["/api/v1/categories"] = { request in
            return self.productCategories()
        }
        
        server["/api/v1/products"] = { request in
            return self.products()
        }
        
        server["/api/v1/orders/:id"] = { request in
            if let orderId = request.params[":id"], orderId.count > 0 {
                print("OrderID : \(orderId)")
                return self.orders(query: [("orderId", orderId)])
            } else {
                return self.orders(query: request.queryParams)
            }
        }
        
        server.POST["/api/v1/orders"] = { request in
            return self.newOrder(bodyData: Data(bytes: request.body, count: request.body.count))
        }
        
        try! server.start()
    }
    
    //curl -k -X GET --header 'Content-Type: application/json' http://192.168.86.153:8080/api/v1/categories/
    func productCategories() -> HttpResponse {
        let productCategoriesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCategory")
        
        do {
            let productCategories = try persistentContainer.viewContext.fetch(productCategoriesFetch) as! [ProductCategory]
            let encoded = try JSONEncoder().encode(productCategories)
            //print(String(decoding: encoded, as: UTF8.self))
            return HttpResponse.ok(.text(String(decoding: encoded, as: UTF8.self)))
        } catch {
            return HttpResponse.internalServerError
        }
    }
    
    //curl -k -X GET --header 'Content-Type: application/json' http://192.168.86.153:8080/api/v1/products/
    func products() -> HttpResponse {
        let productsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        
        do {
            let products = try persistentContainer.viewContext.fetch(productsFetch) as! [Product]
            let encoded = try JSONEncoder().encode(products)
            //print(String(decoding: encoded, as: UTF8.self))
            return HttpResponse.ok(.text(String(decoding: encoded, as: UTF8.self)))
        } catch {
            return HttpResponse.internalServerError
        }
    }
    
    
    //curl -k -X GET --header 'Content-Type: application/json' http://192.168.86.153:8080/api/v1/orders/
    func orders(query:[(String, String)]) -> HttpResponse {
        let ordersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        
        if query.count > 0 {
            let (key, value) = query[0]
            let predicate = NSPredicate(format: "\(key) = %@", argumentArray: [value])
            ordersFetch.predicate = predicate
        }
        
        do {
            let orders = try persistentContainer.viewContext.fetch(ordersFetch) as! [Order]
            let encoded = try JSONEncoder().encode(orders)
            //print(String(decoding: encoded, as: UTF8.self))
            return HttpResponse.ok(.text(String(decoding: encoded, as: UTF8.self)))
        } catch {
            return HttpResponse.internalServerError
        }
    }
    
    //curl -v -k -H "Content-Type: aapplication/json; charset=UTF-8" -X POST -d '{"table": "1", "orderItems": []}' http://192.168.86.153:8080/api/v1/orders
    
    func newOrder(bodyData data: Data) -> HttpResponse {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let orderDict = json as? [String: Any] {
                if let orderTable = orderDict["table"] as? String {
                    let order = Order(context: persistentContainer.viewContext)
                    order.table = orderTable
                    let orderDate = Date()
                    order.datetime = orderDate
                    order.orderReady = false
                    order.orderId = "\(orderDate.timeIntervalSince1970)-\(orderTable)"
                    try persistentContainer.viewContext.save()
                    let responseBody = "{'orderId': '\(order.orderId!)'}"
                    return HttpResponse.ok(.text(responseBody))
                }
            }
        } catch {
        }
        return HttpResponse.internalServerError
    }
}
