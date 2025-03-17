//
//  ContentView.swift
//  GreenScan
//
//  Created by Francesco Sallia on 04.03.25.
//

import SwiftUI
import CodeScanner


struct ScannerView: View {
  
    @ObservedObject var viewModelScanner: ScannerViewModel
    @Environment(\.modelContext) var context
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.costumBackground
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        CodeScannerView(codeTypes: [.qr, .ean8, .ean13, .aztec], scanMode: .once) { result in
                            
                            switch result {
                            case .success(let code):
                                viewModelScanner.isScanning.toggle()
                                viewModelScanner.scannedBarcode = code.string  // Neuen Barcode speichern
                                print("ScannedProdukt from ScannedBarcode: \(viewModelScanner.scannedBarcode)")
                                print(viewModelScanner.scannedProduct?.product?.code ?? "Produkt nicht verfügbar")
//                                viewModelScanner.scannedProduct = nil  // Altes Produkt zurücksetzen
                                viewModelScanner.isLoading = true   // Ladezustand anzeigen
                                Task {
                                    await viewModelScanner.getScannedProducts()
                                    
                                    if let scannedProduct = viewModelScanner.scannedProduct, scannedProduct.status == 1 {
                                        print("ScannedProdukt: \(scannedProduct.product?.code ?? "Kein Code")")
                                        print("ScannedProdukt: \(scannedProduct.status ?? 0000)")
                                            
                                            context.insert(scannedProduct)  // Richtiges Speichern
                                            try? context.save()

                                    } else {
                                        print("Kein gültiges Produkt gefunden, wird nicht in der Datenbank gespeichert.")
                                    }
                                }
                                viewModelScanner.navigateToDetailView.toggle()
                            
                            case .failure(let error):
                                print("Fehler: \(error)")
                            }
                        }
                        RoundedRectangle(cornerRadius: 12)
                            .border(viewModelScanner.isScanning ? Color.green : Color.black, width: 4)
                            .border(viewModelScanner.showSheet ? Color.green : Color.black, width: 4)
                            .frame(width: 270, height: 150)
                            .foregroundStyle(.clear)
                    }
                    
                    .navigationDestination(isPresented: $viewModelScanner.navigateToDetailView) {
                        if let detailProduct = viewModelScanner.productDetail {
                            
                            ScannedProductDetail(viewModelScanner: viewModelScanner, product: detailProduct.product)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScannerView(viewModelScanner: ScannerViewModel())
}
