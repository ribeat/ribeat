//
//  OrderViewController.swift
//  Ribeat
//
//  Created by Emanuel Covaci on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import UIKit
import CoreData

class OrderViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var tableName: String = ""
    var tableID: Int = 1
    var images =  [UIImage(named: "p_bbq"), UIImage(named: "p_beef"), UIImage(named: "p_caesar"), UIImage(named: "pc_fish"), UIImage(named: "p_pineappleGinger")]
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    var orderDetails: Order = Order()

    
    @IBOutlet var productTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTable.delegate = self
        productTable.dataSource = self
        productTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        productTable.rowHeight = 44.0
        productTable.separatorColor = UIColor.white
        
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        title = tableName
        print("Table ID: \(tableID)")
        getOrdersWithTableID(id: tableID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = "Hello World"
        cell.imageView?.image = images.randomElement() ?? images[0]
        
        return cell
    }
    
    @IBAction func cashButtonPressed(_ sender: AnyObject) {
        print("Cash")
        payment(with: "cash", amount: 28.50)
    }
    
    @IBAction func cardButtonPressed(_ sender: AnyObject) {
        print("Card")
        payment(with: "card", amount: 30.99)
    }
    
    func payment(with paymentType: String, amount: Double){
        let alert = UIAlertController(title: "Are you sure that do you want to pay \(amount) euro with the \(paymentType) method?", message: "", preferredStyle: .alert)
        
        let positiveResponse = UIAlertAction(title: "YES", style: .default) { (action) in
            print("Yes, I'm sure")
        }
        
        let nagativeResponse = UIAlertAction(title: "NO", style: .default) { (action) in
            print("No, was an error")
        }
        
        
        alert.addAction(positiveResponse)
        alert.addAction(nagativeResponse)
        present(alert, animated: true, completion: nil)
    }
    
    func getOrdersWithTableID(id: Int){
        
        let ordersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        let predicate = NSPredicate(format: "table = %@", argumentArray: [id])
        ordersFetch.predicate = predicate
        
        do {
            let orders = try persistentContainer.viewContext.fetch(ordersFetch) as! [Order]
            let encoded = try JSONEncoder().encode(orders)
//            orderDetails = orders[0]
            print(orders.count)
        //    print(String(decoding: encoded, as: UTF8.self))
         //   print(orderDetails)
            
        } catch {
            print(error)
        }
        
    }
    

}



