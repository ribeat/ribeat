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
    incrementId += 1
}

fileprivate func addStarters(_ context: NSManagedObjectContext) {
    let startersImage = RibImage(context: context)
    startersImage.isDefault = true
    startersImage.name = "Starters"
    startersImage.fileName = "pc_starters"
    
    let starters = ProductCategory(context: context)
    starters.pcId = incrementId
    starters.name = "Starters"
    starters.deliveryOrder = 1
    starters.ribImage = startersImage
    incrementId += 1
    
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
}


fileprivate func addSalads(_ context: NSManagedObjectContext) {
    let pcImage = RibImage(context: context)
    pcImage.isDefault = true
    pcImage.name = "Salads"
    pcImage.fileName = "pc_salad"
    
    let prodCat = ProductCategory(context: context)
    prodCat.pcId = incrementId
    prodCat.name = "Salads"
    prodCat.deliveryOrder = 1
    prodCat.ribImage = pcImage
    incrementId += 1
    
    addProduct(context, prodCat, "Greek",
               "p_greek", "Organic Mixed Greens, Romaine, Organic Cucumbers, Red Onions, Green Onions, Organic Tomatoes, Kalamata Olives and Feta Cheese  GF\n170 CAL | 2.5G SAT FAT | 9G PROTEIN | 18G CARBS | 6G FIBER",
               "food", 5.75)
    addProduct(context, prodCat, "BBQ Ranch",
               "p_bbq", "Organic Mixed Greens, Romaine, Corn, Organic Black Beans, Pico de Gallo, Avocados, Tortilla Strips and Pepper Jack Cheese\n440 CAL | 6G SAT FAT | 15G PROTEIN | 55G CARBS | 14G FIBER",
               "food", 6.45)
    addProduct(context, prodCat, "Caesar",
               "p_caesar", "Romaine, Organic Tomatoes, Sourdough Croutons, Parmesan Cheese and Fresh Cracked Black Pepper\n180 CAL | 1.5G SAT FAT | 9G PROTEIN | 21G CARBS | 8G FIBER",
               "food", 5.35)
    addProduct(context, prodCat, "Mixed Greens & Apples",
               "p_saladMixed", "Organic Mixed Greens, Romaine, Organic Raisins, Pecans, Organic Apples and Blue Cheese Crumbles\nCONTAINS NUTS GF\n430 CAL | 6G SAT FAT | 12G PROTEIN | 45G CARBS | 8G FIBER",
               "food", 7.10)
}


fileprivate func addBurgers(_ context: NSManagedObjectContext) {
    let pcImage = RibImage(context: context)
    pcImage.isDefault = true
    pcImage.name = "Burgers"
    pcImage.fileName = "pc_burgers"
    
    let prodCat = ProductCategory(context: context)
    prodCat.pcId = incrementId
    prodCat.name = "Burgers"
    prodCat.deliveryOrder = 4
    prodCat.ribImage = pcImage
    incrementId += 1
    
    addProduct(context, prodCat, "Chicken Burger",
               "p_chicken", "If you prefer your burger without the bun, just let our team know & we will give you a portion of coleslaw or a mixed leaf salad instead.",
               "food", 7.50)
    addProduct(context, prodCat, "Beef Burger",
               "p_beef", "100% PRIME SCOTCH BEEF Our burgers are handmade from scratch HERE every day, using traditionally reared 100% prime Scotch beef. They’re then flame-grilled to order, to create the best tasting burger",
               "food", 8.00)
    addProduct(context, prodCat, "Smokey Burger",
               "p_smokeyBurger", " Beef burger, home made bun, crispy onion, cheddar, bacon, BBQ sauce, hand cut Fresh Fries L-G-O-T-S",
               "food", 10.00)
    addProduct(context, prodCat, "Caprese Burger",
               "p_capreseBurger.PNG", " Beef burger, homemade bread bun, mozzarella, rucola, tomato, hand cut Fresh Fries, fresh herbs pesto with peanuts L-G-O-T-S",
               "food", 10.00)
}


fileprivate func addMeat(_ context: NSManagedObjectContext) {
    let pcImage = RibImage(context: context)
    pcImage.isDefault = true
    pcImage.name = "Meat"
    pcImage.fileName = "pc_meat"
    
    let prodCat = ProductCategory(context: context)
    prodCat.pcId = incrementId
    prodCat.name = "Meat"
    prodCat.deliveryOrder = 5
    prodCat.ribImage = pcImage
    incrementId += 1
    
    addProduct(context, prodCat, "Master Rib Eye Australia",
               "p_ribeyeAus", "Australian rib eye steak, well marbled, with fat area inside",
               "food", 30.50)
    addProduct(context, prodCat, "T-Bone Steak (600 gr)",
               "p_tboneUsa", "The T shaped bone combines the flavor of the sirloin with the tenderness of the tenderloin, USA origin, premium quality",
               "food", 50.00)
    addProduct(context, prodCat, "Truffles & Foie Gras Tenderloin",
               "p_tenderloin", "Australian tenderloin steak with foie gras, asparagus, Fresh Fries, wild mushrooms and truffles N-SD",
               "food", 35.00)
}


fileprivate func addFish(_ context: NSManagedObjectContext) {
    let pcImage = RibImage(context: context)
    pcImage.isDefault = true
    pcImage.name = "Fish"
    pcImage.fileName = "pc_fish"
    
    let prodCat = ProductCategory(context: context)
    prodCat.pcId = incrementId
    prodCat.name = "Fish"
    prodCat.deliveryOrder = 5
    prodCat.ribImage = pcImage
    incrementId += 1
    
    addProduct(context, prodCat, "Fried Calamri",
               "p_calamari", "Artichoke hearts, spicy marinara sauce, lemon aioli",
               "food", 15.00)
    addProduct(context, prodCat, "Crispy Atlantic Salmon & Scallop",
               "p_salmon", "Spicy ginger glazed salmon with seared shrimp, scallop, & jumbo lump crab over fresh sautéed spinach",
               "food", 27.00)
    addProduct(context, prodCat, "Texas Redfish Pontchartrain",
               "p_redfish", "Pan-grilled redfish with jumbo lump crabmeat & shrimp in a brown-butter wine sauce, with dirty rice",
               "food", 29.00)
}


fileprivate func addNonAlcoholic(_ context: NSManagedObjectContext) {
    let pcImage = RibImage(context: context)
    pcImage.isDefault = true
    pcImage.name = "Non-alcoholic Beverages"
    pcImage.fileName = "pc_nonalcohol"
    
    let prodCat = ProductCategory(context: context)
    prodCat.pcId = incrementId
    prodCat.name = "Non-alcoholic Beverages"
    prodCat.deliveryOrder = 0
    prodCat.ribImage = pcImage
    incrementId += 1
    
    addProduct(context, prodCat, "Non-Alcoholic Orange Slush Punch",
               "p_nonOrangeSlush", "Refreshingly sweet with a tart, citrus twist",
               "drink", 3.00)
    addProduct(context, prodCat, "Cherry-Infused Dr. Pepper",
               "p_drPepper", "This cherry-infused punch pops with Dr. Pepper™ flavor!",
               "drink", 3.70)
    addProduct(context, prodCat, "Pineapple Ginger Sparkler",
               "p_pineappleGinger", "Fresh enough for spring and summer, spicy enough for warmer months.",
               "drink", 2.50)
}


fileprivate func addAlcoholic(_ context: NSManagedObjectContext) {
    let pcImage = RibImage(context: context)
    pcImage.isDefault = true
    pcImage.name = "Alcoholic Beverages"
    pcImage.fileName = "pc_alcohol"
    
    let prodCat = ProductCategory(context: context)
    prodCat.pcId = incrementId
    prodCat.name = "Alcoholic Beverages"
    prodCat.deliveryOrder = 0
    prodCat.ribImage = pcImage
    incrementId += 1
    
    addProduct(context, prodCat, "Grenache Carignan Merlot",
               "p_merlot", "Richelieu, Pays d’Herault, France, 12%\nBalanced & flavoursome, juicy fruit, a great complex wine",
               "drink", 73.00)
    addProduct(context, prodCat, "Carmenere",
               "p_carmenere", "Turi, Central Valley, Chile, 13.5% Deep mature aromas, soft & juicy, subtle oak",
               "drink", 37.50)
    addProduct(context, prodCat, "Pinot Grigio Bollini",
               "p_pinot", "Southern Italy\nIntense varietal white fruit flavors, An excellent Pinot with crisp and clean acid balance on the palate",
               "drink", 52.50)
}

func populateInitialData(container: NSPersistentContainer) {
    let context = container.viewContext
    
    let productCategoriesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCategory")
    
    do {
        let productCategories = try container.viewContext.fetch(productCategoriesFetch) as! [ProductCategory]
        if productCategories.count == 0 {
            incrementId = 1
            addStarters(context)
            addSalads(context)
            addBurgers(context)
            addMeat(context)
            addFish(context)
            addNonAlcoholic(context)
            addAlcoholic(context)
        }
    } catch {
    }
    
}
