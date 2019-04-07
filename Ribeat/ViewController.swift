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
        tableID = Int(sender.tag!)
        let size = getOrdersWithTableID(id: tableID)
        if size == 0 {
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
        let predicate = NSPredicate(format: "table = %@ && orderReady = 0", argumentArray: [id])
        ordersFetch.predicate = predicate
        
        var ordersCount = 0
        
        do {
            let orders = try persistentContainer.viewContext.fetch(ordersFetch) as! [Order]
            ordersCount = orders.count
        } catch {
            print(error)
        }

        return ordersCount
        
    }



}

