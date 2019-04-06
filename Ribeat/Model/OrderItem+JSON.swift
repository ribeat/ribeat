//
//  OrderItem+JSON.swift
//  Ribeat
//
//  Created by Alin Brindusescu on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import Foundation
extension OrderItem : Encodable {
    private enum CodingKeys : String, CodingKey {
        case oiId="id", baypassDeliveryOrder, quantity, order="orderId", product="productId"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(baypassDeliveryOrder, forKey: .baypassDeliveryOrder)
        try container.encode(oiId, forKey: .oiId)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(order?.orderId, forKey: .order)
        try container.encode(product?.pId, forKey: .product)
    }
}
