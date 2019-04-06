//
//  PopulateInitialData.swift
//  Ribeat
//
//  Created by Alin Brindusescu on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

var incrementId: Int32 = 1

fileprivate func addProduct(_ context: NSManagedObjectContext, _ productCategory: ProductCategory, _ name: String, _ imageFileName: String, _ details:String, _ type: String, _ price: Double ) {
    let productImage = RibImage(context: context)
    productImage.isDefault = true
    productImage.name = name
    productImage.fileName = imageFileName
    
    let product = Product(context: context)
    product.pId = incrementId
    product.name = name
    product.details = details
    product.price = price
    product.type = type
    product.vat = 9.0
    product.ribImage = productImage
    
    productCategory.addToProducts(product)
    incrementId += incrementId
}

func populateInitialData(container: NSPersistentContainer) {
    let context = container.viewContext
    
    let startersImage = RibImage(context: context)
    startersImage.isDefault = true
    startersImage.name = "Starters"
    startersImage.fileName = "pc_starters"
 
    let starters = ProductCategory(context: context)
    starters.pcId = incrementId
    starters.name = "Starters"
    starters.deliveryOrder = 1
    starters.ribImage = startersImage
    incrementId += incrementId
    
    addProduct(context, starters, "Spring Rolls",
               "p_springRolls", "Minced pork, shredded carrot, bean sprouts and other vegetables",
               "food", 12.50)
    addProduct(context, starters, "Fried Pickles",
               "p_friedPickles", "Slim breaded pickles, spicy aioli",
               "food", 17.50)
    addProduct(context, starters, "Cheese Curds",
               "p_friedCheeseCurds", "White cheddar cheese curds, spicy aioli",
               "food", 9.00)
    addProduct(context, starters, "Crab Cakes",
               "p_crabCakes", "Lump crab, spring mix, tartar sauce",
               "food", 18.99)
    
    
    
    
    
    
//    productCat.im

    /*
     3-5 articles per group
     Starters
    BURGERS
    SALADS.
    FISH.
    MEAT
    alcoholic beverages
     Non-alcoholic Beverages
 */
}
