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
    var ordersList: [Order] = [Order]()
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
        cell.textLabel?.text = "\(name)  \(price) RON/Buc"
        let ribImage =  products[indexPath.row].ribImage as! RibImage
        cell.imageView?.image = UIImage(named: ribImage.fileName!)
        
        return cell
    }
    
    @IBAction func cashButtonPressed(_ sender: AnyObject) {
        payment(with: "cash", amount: totalPrice)
    }
    
    @IBAction func cardButtonPressed(_ sender: AnyObject) {
        payment(with: "card", amount: totalPrice)
    }
    
    func payment(with paymentType: String, amount: Double){
        let alert = UIAlertController(title: "Are you sure that do you want to pay \(amount) RON with the \(paymentType) method?", message: "", preferredStyle: .alert)
        
        let positiveResponse = UIAlertAction(title: "YES", style: .default) { (action) in
            self.setOrderToReady()
        }
        
        let nagativeResponse = UIAlertAction(title: "NO", style: .default) { (action) in
        }
        
        
        alert.addAction(positiveResponse)
        alert.addAction(nagativeResponse)
        present(alert, animated: true, completion: nil)
    }
    
    func getOrdersWithTableID(id: Int){
        
        let ordersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        let predicate = NSPredicate(format: "table = %@ && orderReady = 0", argumentArray: [id])
        ordersFetch.predicate = predicate
        
        do {
            let orders = try persistentContainer.viewContext.fetch(ordersFetch) as! [Order]
            for order in orders{
                ordersList.append(order as! Order)
                for item in order.items!{
                    let orderItem = item as! OrderItem
                    for _ in 0 ..< orderItem.quantity{
                         products.append(orderItem.product as! Product)
                    }
                   
                }
            }
            
            for product in products{
                totalPrice += product.price
            }
            
            totalPriceLabel.text = "Total: \(totalPrice) RON"
            
        
            
        } catch {
            print(error)
        }
        
    }
    
    func setOrderToReady(){
        for order in self.ordersList{
            let ordersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
            let predicate = NSPredicate(format: "orderId = %@", argumentArray: [order.orderId])
            ordersFetch.predicate = predicate
            do {
                let ordersByID = try self.persistentContainer.viewContext.fetch(ordersFetch) as! [Order]
                
                ordersByID[0].orderReady = 1;
                
                do{
                    try self.persistentContainer.viewContext.save()
                    
                }catch{
                    print("Error saving context \(error)")
                }
                
                
            } catch {
                print(error)
            }
            
            print("Done")
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    

}



