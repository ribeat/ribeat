//
//  ViewController.swift
//  Ribeat
//
//  Created by Alin Brindusescu on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var tableID: Int = 1
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    @IBAction func buttonSelected(_ sender: AnyObject) {
        print(sender.tag)
       // table = "Table No. \(sender.tag!)"
        tableID = Int(sender.tag!)
        if getOrdersWithTableID(id: tableID) == 0{
            performSegue(withIdentifier: "goTo404", sender: self)
        }
        else {
            performSegue(withIdentifier: "goToTable", sender: self)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTable"{
            
            let destinationVC = segue.destination as! OrderViewController
            destinationVC.tableName = "Table No. \(tableID)"
            destinationVC.tableID = tableID
        
        }
    }
    
    func getOrdersWithTableID(id: Int)-> Int{
        
        let ordersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        let predicate = NSPredicate(format: "table = %@", argumentArray: [id])
        ordersFetch.predicate = predicate
        
        var ordersCount = 0
        
        do {
            let orders = try persistentContainer.viewContext.fetch(ordersFetch) as! [Order]
            let encoded = try JSONEncoder().encode(orders)
            //            orderDetails = orders[0]
            print(orders.count)
            ordersCount = orders.count
            //    print(String(decoding: encoded, as: UTF8.self))
            //   print(orderDetails)
            
        } catch {
            print(error)
        }

        return ordersCount
        
    }



}

