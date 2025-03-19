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
    @Published var scannedList: [ScannedProduct] = []
    @Published var navigateToDetailView: Bool = false
    @Published var productDetail: ScannedProduct? = nil


    
    
    private let client = HttpClient()

    
    func nutriScoreGradient(_ score: String) -> LinearGradient {
        
        let green = LinearGradient(colors: [.green.opacity(0.5)], startPoint: .top, endPoint: .bottom)
        let yellow = LinearGradient(colors: [.yellow.opacity(0.5)], startPoint: .top, endPoint: .bottom)
        let orange = LinearGradient(colors: [.orange.opacity(0.5)], startPoint: .top, endPoint: .bottom)
        let red = LinearGradient(colors: [.red.opacity(0.5)], startPoint: .top, endPoint: .bottom)
        let defaultGray = LinearGradient(colors: [.gray.opacity(0.5)], startPoint: .top, endPoint: .bottom)

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
    
    func getNutriScoreColor(value: String) -> Color {
        
            switch value {
            case "a".uppercased():
                return .green
            case "b".uppercased():
                return .green.opacity(0.8)
            case "c".uppercased():
                return .yellow
            case "d".uppercased():
                return .orange
            case "e".uppercased():
                return .red
            default:
                return .gray
            }
        }
    
     func isUnknownScore(value: String) -> String {
       guard value != "unknown".uppercased(), value != "not-applicable".uppercased() else { return "?" }
        return value
        }
    
    
//API-SECTION
    func getScannedProducts() async {
        guard !scannedBarcode.isEmpty else { return }
        
        isLoading = true
        do {
            let product = try await client.getScannedProduct(barcode: scannedBarcode)
            scannedProduct = product
            productDetail = product
            self.scannedList.append(product)            
        } catch {
            print("Fehler: \(error)") // TODO: error handler benutzen!
            scannedProduct = nil
        }
        isLoading = false
        isScanning.toggle()
        
    }
    
    
    
    
    
}
