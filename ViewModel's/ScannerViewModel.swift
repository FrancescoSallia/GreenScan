//
//  ScannerViewModel.swift
//  GreenScan
//
//  Created by Francesco Sallia on 04.03.25.
//

import Foundation
import CodeScanner

@MainActor
class ScannerViewModel: ObservableObject {
    
    @Published var scannedProduct: ScannedProduct? = nil
    @Published var showSheet: Bool = false
    @Published var scannedBarcode: String = ""
    @Published var isLoading: Bool = false
    @Published var isScanning: Bool = false
    var scannedList: [ScannedProduct] = []
    
    
    private let client = HttpClient()

    
    func getScannedProducts() async {
        guard !scannedBarcode.isEmpty else { return }
        
        isLoading = true
        do {
            let product = try await client.getScannedProduct(barcode: scannedBarcode)
            scannedProduct = product
            self.scannedList.append(product)
        } catch {
            print("Fehler: \(error)")
            scannedProduct = nil
        }
        isLoading = false
    }
    
    
    
    
    
}
