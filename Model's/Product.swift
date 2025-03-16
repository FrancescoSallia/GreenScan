//
//  Product.swift
//  GreenScan
//
//  Created by Francesco Sallia on 04.03.25.
//

import Foundation

struct Product: Identifiable, Codable {
        
    var id: String? = UUID().uuidString
    var code: String?
    var status: String?
    var product_name_de: String? = "Kein Name verfügbar"
    var ingredients_text_de: String? = "Keine Zutaten verfügbar"
    var allergens_imported: String? = "Keine Allergene verfügbar"
    var allergens_from_ingredients: String? = "Keine Allergene verfügbar"
    var image_url: String? = "https://via.placeholder.com/150" // Beispiel-Bild-URL als Default
    var image_nutrition_url: String? = "https://via.placeholder.com/150"
    var nutriments: Nutriments? = Nutriments() // Standardwert für Nutriments
    var nutriscore_grade: String? = "Keine Bewertung"
    var ecoscore_score: Int? = 0
    var ingredients: [Ingredient]? = []
    var brands: String? = "(Keine Marke verfügbar)"
   
}

