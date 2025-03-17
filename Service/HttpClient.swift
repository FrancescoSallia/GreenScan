//
//  HttpClient.swift
//  GreenScan
//
//  Created by Francesco Sallia on 04.03.25.
//

import Foundation

class HttpClient {
    
    func getScannedProduct(barcode: String) async throws -> ScannedProduct {
        guard let url = URL(string: "https://world.openfoodfacts.org/api/v2/product/\(barcode).json") else {
            throw ErrorEnum.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let scannedProduct = try JSONDecoder().decode(ScannedProduct.self, from: data)
            print("scannedProduct from HTTP-Client: \(scannedProduct)")
            print("scannedProduct from HTTP-Client Status: \(scannedProduct.product?.status ?? "No Status HTTP-Client")")
            return scannedProduct
        } catch {
            print("Fehler beim Dekodieren: \(error)")
            throw error
        }
    }
}
