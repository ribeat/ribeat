//
//  RibImage+JSON.swift
//  Ribeat
//
//  Created by Alin Brindusescu on 06/04/2019.
//  Copyright © 2019 Alin Brindusescu. All rights reserved.
//

import UIKit
import Foundation

extension RibImage : Encodable {
    private enum CodingKeys : String, CodingKey {
        case fileName="image", isDefault, name, categoryImage, productImage
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(UIImage(named: fileName!)!.jpegData(compressionQuality: 0.5)!.base64EncodedData(), forKey: .fileName)
        try container.encode(isDefault, forKey: .isDefault)
        try container.encode(name, forKey: .name)
    }
}
