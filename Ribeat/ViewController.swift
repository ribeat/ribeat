//
//  ViewController.swift
//  Ribeat
//
//  Created by Alin Brindusescu on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var table: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    @IBAction func buttonSelected(_ sender: AnyObject) {
        print(sender.tag)
        table = "Table No. \(sender.tag!)"
        performSegue(withIdentifier: "goToTable", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTable"{
            
            let destinationVC = segue.destination as! OrderViewController
            destinationVC.table = table
        
        }
    }



}

