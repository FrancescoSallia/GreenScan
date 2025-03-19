//
//  NutrimentsCodingKeys.swift
//  GreenScan
//
//  Created by Francesco Sallia on 19.03.25.
//

import Foundation

enum NutrimentsCodingKeys: String, CodingKey {
    case energy_kcal_100g = "energy-kcal_100g"
    case fat_100g
    case saturated_fat_100g = "saturated-fat_100g"
    case carbohydrates_100g
    case sugars_100g
    case fiber_100g
    case proteins_100g
    case salt_100g
}
