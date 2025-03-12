//
//  Product.swift
//  GreenScan
//
//  Created by Francesco Sallia on 04.03.25.
//

import Foundation

struct Product: Identifiable, Codable {
        
    var id: String
    let allergens_imported: String?
    let product_name_de: String?
    let image_url: String?
    let labels: String?
    let carbon_footprint: String?
    let nutriscore_grade: String?
    let packaging: String?
    let ecoscore_score: Int?
    let ingredients_text_de: String?
    let image_nutrition_url: String?
    let nutriments: Nutriments?
}

