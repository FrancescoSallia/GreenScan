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
    var status: Int?
    var status_verbose: String?
    var product: Product?
    
    init(code: String? = nil, product: Product? = nil, status: Int? = nil, status_verbose: String? = nil) {
        self.code = code
        self.product = product
        self.status = status
        self.status_verbose = status_verbose
    }
    
    // MARK: - Codable Conformance
    
    /* required init(from decoder: Decoder) throws ist nötig, wenn die Klasse Unterklassen haben kann.
     Es stellt sicher, dass alle Unterklassen diesen Initializer implementieren.
     Ohne required müsste jede Unterklasse ihren eigenen Initializer definieren. */
    
       required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           code = try container.decodeIfPresent(String.self, forKey: .code)
           product = try container.decodeIfPresent(Product.self, forKey: .product)
           status = try container.decodeIfPresent(Int.self, forKey: .status)
           status_verbose = try container.decodeIfPresent(String.self, forKey: .status_verbose)
       }
       
       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encodeIfPresent(code, forKey: .code)
           try container.encodeIfPresent(product, forKey: .product)
           try container.encodeIfPresent(status, forKey: .status )
           try container.encodeIfPresent(status_verbose, forKey: .status_verbose )
       }
    
    
//    enum CodingKeys: String, CodingKey {
//            case code, product, status, status_verbose
//        }
}

