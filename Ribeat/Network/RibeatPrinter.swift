//
//  RibeatPrinter.swift
//  Ribeat
//
//  Created by Alin Brindusescu on 07/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//
import SwiftSocket
import Foundation

class RibeatPrinter: NSObject {
    var address: String
    var port: Int32
    
    init(withIp ip: String, andPort port: Int32) {
        self.address = ip
        self.port = port
    }
    
    func send(order: Order) {
        if let sendData = order.getPrinterPayload() {
            let client = TCPClient(address: address, port: port)
            switch client.connect(timeout: 1) {
            case .success:
                switch client.send(string: sendData) {
                case .success:
                    guard let data = client.read(1024 * 10) else { return }
                    
                    if let response = String(bytes: data, encoding: .utf8) {
                        print(response)
                    }
                case .failure(let error):
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
