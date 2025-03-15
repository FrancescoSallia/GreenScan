//
//  ScannedProduct.swift
//  GreenScan
//
//  Created by Francesco Sallia on 04.03.25.
//

import Foundation
import SwiftData

@Model
class ScannedProduct: Codable, Identifiable {
    
    var id: UUID? = UUID()
    var code: String?
    var product: Product?
    
    init(code: String? = nil, product: Product? = nil) {
        self.code = code
        self.product = product
    }
    
    // MARK: - Codable Conformance
    
    /* required init(from decoder: Decoder) throws ist nötig, wenn die Klasse Unterklassen haben kann.
     Es stellt sicher, dass alle Unterklassen diesen Initializer implementieren.
     Ohne required müsste jede Unterklasse ihren eigenen Initializer definieren. */
    
       required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           code = try container.decodeIfPresent(String.self, forKey: .code)
           product = try container.decodeIfPresent(Product.self, forKey: .product)
       }
       
       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encodeIfPresent(code, forKey: .code)
           try container.encodeIfPresent(product, forKey: .product)
       }
    
    
    enum CodingKeys: String, CodingKey {
            case code, product
        }
}

