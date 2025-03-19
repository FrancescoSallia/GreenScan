//
//  Package.swift
//  GreenScan
//
//  Created by Francesco Sallia on 19.03.25.
//

import Foundation

struct Package: Codable, Identifiable {
    var id: String = UUID().uuidString
    var environmental_score_material_score: Int? = 0
    var material: String? = ""
    var recycling: String? = ""
    var shape: String? = ""

       init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.id = UUID().uuidString  // Generiere eine eindeutige ID
           self.environmental_score_material_score = try container.decodeIfPresent(Int.self, forKey: .environmental_score_material_score)
           self.material = try container.decodeIfPresent(String.self, forKey: .material)
           self.recycling = try container.decodeIfPresent(String.self, forKey: .recycling)
           self.shape = try container.decodeIfPresent(String.self, forKey: .shape)
       }
}
