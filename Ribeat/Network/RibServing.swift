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
        
        try! server.start()
    }
    
    
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
    
}
