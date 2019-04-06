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
        
        server.PUT["/api/v1/orders"] = { request in
            return self.updateOrder(bodyData: Data(bytes: request.body, count: request.body.count))
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
    
    func getProduct(productId: Int32) -> Product? {
        let productFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        let predicate = NSPredicate(format: "pId = %d", argumentArray: [productId])
        productFetch.predicate = predicate
        
        do {
            let products = try persistentContainer.viewContext.fetch(productFetch) as! [Product]
            if products.count > 0 {
                return products[0]
            }
        } catch {
        }
        return nil
    }
    
    func getOrder(orderId: String) -> Order? {
        let ordersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        let predicate = NSPredicate(format: "orderId = %@", argumentArray: [orderId])
        ordersFetch.predicate = predicate
        do {
            let orders = try persistentContainer.viewContext.fetch(ordersFetch) as! [Order]
            if orders.count > 0 {
                return orders[0]
            }
        } catch {
        }
        
        return nil
    }
    
    //curl -v -k -H "Content-Type: application/json; charset=UTF-8" -X POST -d '{"table": "1", "orderItems": [{"productId": 2, "quantity": 2, "baypassDeliveryOrder": false}, {"productId": 10, "quantity": 3, "baypassDeliveryOrder": true}]}' http://192.168.86.153:8080/api/v1/orders
    func newOrder(bodyData data: Data) -> HttpResponse {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let orderDict = json as? [String: Any] {
                if let orderTable = orderDict["table"] as? String {
                    let order = Order(context: persistentContainer.viewContext)
                    order.table = orderTable
                    let orderDate = Date()
                    order.datetime = orderDate
                    order.orderReady = 0
                    order.orderId = "\(orderDate.timeIntervalSince1970)-\(orderTable)"
                    if let oItems = orderDict["orderItems"] as? [[String: Any]] {
                        for oItem in oItems {
                            if let itemProductId = oItem["productId"] as? Int32 {
                                if let product = getProduct(productId: itemProductId) {
                                    let orderItem = OrderItem(context: persistentContainer.viewContext)
                                    orderItem.oiId = "\(order.orderId!)-\(product.pId)"
                                    orderItem.baypassDeliveryOrder = oItem["baypassDeliveryOrder"] as? Bool ?? false
                                    orderItem.quantity = oItem["quantity"] as? Int16 ?? 1
                                    orderItem.product = product
                                    order.addToItems(orderItem)
                                }
                            }
                        }
                    }
                    try persistentContainer.viewContext.save()
                    let responseBody = "{'orderId': '\(order.orderId!)'}"
                    return HttpResponse.ok(.text(responseBody))
                }
            }
        } catch {
        }
        return HttpResponse.internalServerError
    }
    
    
    
    //curl -v -k -H "Content-Type: application/json; charset=UTF-8" -X PUT -d '{"table": "1", "orderId":"1554582345.864249-1", "orderReady": "1", "orderItems": [{"productId": 2, "quantity": 2, "baypassDeliveryOrder": false}, {"productId": 10, "quantity": 3, "baypassDeliveryOrder": true}]}' http://192.168.86.153:8080/api/v1/orders
    func updateOrder(bodyData data: Data) -> HttpResponse {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let orderDict = json as? [String: Any] {
                if let orderId = orderDict["orderId"] as? String {
                    if let order = getOrder(orderId: orderId) {
                        
                        if let orderReady = orderDict["orderReady"] as? String {
                            order.orderReady = Int16(orderReady) ?? 0
                        }
                        
                        if let paymentType = orderDict["paymentType"] as? String {
                            order.paymentType = paymentType
                        }
                        
                        if let companyNmber = orderDict["companyNmber"] as? String {
                            order.companyNmber = companyNmber
                        }
                        
                        try persistentContainer.viewContext.save()
                        let responseBody = "{'orderId': '\(order.orderId!)'}"
                        return HttpResponse.ok(.text(responseBody))
                    }
                }
            }
        } catch {
        }
        return HttpResponse.internalServerError
    }
}
