//
//  Product+JSON.swift
//  Ribeat
//
//  Created by Alin Brindusescu on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import Foundation

extension Product : Encodable {
    private enum CodingKeys : String, CodingKey {
        case pId="id", barcode, details, name, price, type, vat, category="categoryId", orderItem, ribImage="image"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pId, forKey: .pId)
        //try container.encode(barcode, forKey: .barcode)
        try container.encode(details, forKey: .details)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(type, forKey: .type)
        try container.encode(vat, forKey: .vat)
        try container.encode(category?.pcId, forKey: .category)
        try container.encode(ribImage?.getImageData() ?? nil, forKey: .ribImage)
        //try container.encode(products ?? nil, forKey: .products)
    }
}
