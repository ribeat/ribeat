//
//  ProductCategory+JSON.swift
//  Ribeat
//
//  Created by Alin Brindusescu on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import Foundation

extension ProductCategory : Encodable {
    private enum CodingKeys : String, CodingKey {
        case pcId="id", deliveryOrder, name, ribImage, products
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pcId, forKey: .pcId)
        try container.encode(deliveryOrder, forKey: .deliveryOrder)
        try container.encode(name, forKey: .name)
        try container.encode(ribImage ?? nil, forKey: .ribImage)
        //try container.encode(products ?? nil, forKey: .products)
    }
}
