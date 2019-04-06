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
    
    
//    productCat.im

    /*
    BURGERS.
    SALADS.
    FISH.
    CHICKEN.
    DESSERT BAR.
    MEAT
 Halal
alcoholic beverages
 */
}
