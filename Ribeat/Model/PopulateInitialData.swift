//
//  PopulateInitialData.swift
//  Ribeat
//
//  Created by Alin Brindusescu on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import Foundation
import CoreData


func populateInitialData(container: NSPersistentContainer) {
    let context = container.viewContext
    
    let starters = ProductCategory(context: context)
    starters.name = "Starters"
    starters.deliveryOrder = 1
    
    let startOne = Product(context: context)
    startOne.name = "Spring Rolls"
    startOne.details = "Spring Rolls vegetarian or pork meat"
    startOne.price = 12.50
    startOne.type = "food"
    startOne.vat = 9.0
    
    starters.addToProducts(startOne)
    
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
