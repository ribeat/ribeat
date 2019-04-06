//
//  OrderViewController.swift
//  Ribeat
//
//  Created by Emanuel Covaci on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    var table: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = table
    }
    

   

}
