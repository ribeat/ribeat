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
    var totalPrice:Double = 0.0
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    var orderDetails: Order = Order()
    var products: [Product] = [Product]()

    @IBOutlet var totalPriceLabel: UILabel!
    
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
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.white
        let price = products[indexPath.row].price
        let name = products[indexPath.row].name!
        totalPrice += price
        totalPriceLabel.text = "Total: \(totalPrice) $"
        cell.textLabel?.text = "\(name)  \(price) $/Buc"
        let ribImage =  products[indexPath.row].ribImage as! RibImage
        cell.imageView?.image = UIImage(named: ribImage.fileName!)
        
        return cell
    }
    
    @IBAction func cashButtonPressed(_ sender: AnyObject) {
        print("Cash")
        payment(with: "cash", amount: totalPrice)
    }
    
    @IBAction func cardButtonPressed(_ sender: AnyObject) {
        print("Card")
        payment(with: "card", amount: totalPrice)
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
            for order in orders{
                for item in order.items!{
                    let orderItem = item as! OrderItem
                    products.append(orderItem.product as! Product)
                }
            }
        
            
        } catch {
            print(error)
        }
        
    }
    

}



