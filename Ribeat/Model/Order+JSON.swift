//
//  Order+JSON.swift
//  Ribeat
//
//  Created by Alin Brindusescu on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import Foundation

extension Order : Encodable {
    private enum CodingKeys : String, CodingKey {
        case orderId="id", table, companyNmber, datetime, orderReady, paymentType, tipValue, totalPaid, waiter, items
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderId, forKey: .orderId)
        try container.encode(table, forKey: .table)
        try container.encode(companyNmber, forKey: .companyNmber)
        try container.encode(datetime, forKey: .datetime)
        try container.encode(orderReady, forKey: .orderReady)
        try container.encode(paymentType, forKey: .paymentType)
        try container.encode(tipValue, forKey: .tipValue)
        try container.encode(totalPaid, forKey: .totalPaid)
        try container.encode(waiter, forKey: .waiter)
        if let orderItems = items?.allObjects as? [OrderItem] {
            try container.encode(orderItems, forKey: .items)
        }
    }
    
    func getPrinterPayload() -> String? {
        return """
        LF
        LF
        LF
        HackTM Oradea
        LF
        LF
        \(self.orderId)
        """
    }
    
    
}
