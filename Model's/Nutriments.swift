//
//  Nutriments.swift
//  GreenScan
//
//  Created by Francesco Sallia on 11.03.25.
//

import Foundation

struct Nutriments: Codable {
    
    let energy_kcal_100g: Double?
    let fat_100g: Double?
    let saturated_fat_100g: Double?
    let carbohydrates_100g: Double?
    var sugars_100g: Double? = 0.0
    let fiber_100g: Double?
    let proteins_100g: Double?
    let salt_100g: Double?

//       enum CodingKeys: String, CodingKey {
//           case energy_kcal_100g = "energy-kcal_100g"
//           case fat_100g = "fat_100g"
//           case saturated_fat_100g = "saturated-fat_100g"
//           case carbohydrates_100g = "carbohydrates_100g"
//           case sugars_100g = "sugars_100g"
//           case fiber_100g = "fiber_100g"
//           case proteins_100g = "proteins_100g"
//           case salt_100g = "salt_100g"
//       }
}
