//
//  ScannerViewModel.swift
//  GreenScan
//
//  Created by Francesco Sallia on 04.03.25.
//

import Foundation
import CodeScanner
import SwiftUICore

@MainActor
class ScannerViewModel: ObservableObject {
    
    @Published var scannedProduct: ScannedProduct? = nil
    @Published var showSheet: Bool = false
    @Published var scannedBarcode: String = ""
    @Published var isLoading: Bool = false
    @Published var isScanning: Bool = false
    var scannedList: [ScannedProduct] = []

    
    
    private let client = HttpClient()

    
    func nutriScoreGradient(_ score: String) -> LinearGradient {
        
        let green = LinearGradient(colors: [.brown.opacity(0.5), .green.opacity(0.5)], startPoint: .top, endPoint: .bottom)
        let yellow = LinearGradient(colors: [.brown.opacity(0.5), .yellow.opacity(0.5)], startPoint: .top, endPoint: .bottom)
        let orange = LinearGradient(colors: [.brown.opacity(0.5), .orange.opacity(0.5)], startPoint: .top, endPoint: .bottom)
        let red = LinearGradient(colors: [.brown.opacity(0.5), .red.opacity(0.5)], startPoint: .top, endPoint: .bottom)
        let defaultGray = LinearGradient(colors: [.white.opacity(0.5), .gray.opacity(0.5)], startPoint: .top, endPoint: .bottom)

           switch score.uppercased() {
           case "A", "B": return green
           case "C": return yellow
           case "D": return orange
           case "E": return red
           default: return defaultGray
           }
       }
    
    func getColor(value: Double) -> Color {
            switch value {
            case 0..<25:
                return .red
            case 25..<50:
                return .orange
            case 50..<75:
                return .yellow
            case 75...100:
                return .green
            default:
                return .blue
            }
        }
    
    
//API-SECTION
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
