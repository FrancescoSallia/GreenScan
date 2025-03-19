//
//  Nutriments.swift
//  GreenScan
//
//  Created by Francesco Sallia on 11.03.25.
//

import Foundation

struct Nutriments: Codable {
   
    var energy_kcal_100g: Int? = 0
      var fat_100g: Double? = 0
      var saturated_fat_100g: Double? = 0.0
      var carbohydrates_100g: Double? = 0.0
      var sugars_100g: Double? = 0.0
      var fiber_100g: Double? = 0.0
      var proteins_100g: Double? = 0
      var salt_100g: Double? = 0.0

//    enum CodingKeys: String, CodingKey {
//        case energy_kcal_100g = "energy-kcal_100g"
//        case fat_100g
//        case saturated_fat_100g = "saturated-fat_100g"
//        case carbohydrates_100g
//        case sugars_100g
//        case fiber_100g
//        case proteins_100g
//        case salt_100g
//    }
}
