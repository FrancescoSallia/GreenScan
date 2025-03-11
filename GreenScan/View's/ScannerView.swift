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

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .border(viewModelScanner.isScanning ? Color.green : Color.clear, width: 2)
                    .frame(width: 200, height: 200)
                CodeScannerView(codeTypes: [.qr, .ean8, .ean13, .aztec], scanMode: .continuous) { result in
                    switch result {
                    case .success(let code):
                        viewModelScanner.isScanning.toggle()
                        viewModelScanner.scannedBarcode = code.string  // Neuen Barcode speichern
                        print(viewModelScanner.scannedProduct?.product?.id ?? "Produkttitel nicht verfügbar")
                        viewModelScanner.scannedProduct = nil  // Altes Produkt zurücksetzen
                        viewModelScanner.isLoading = true   // Ladezustand anzeigen
                        Task {
                            await viewModelScanner.getScannedProducts()
                        }
                        viewModelScanner.showSheet = true
                    case .failure(let error):
                        print("Fehler: \(error)")
                    }
                }
                RoundedRectangle(cornerRadius: 12)
                    .border(viewModelScanner.isScanning ? Color.green : Color.black, width: 4)
                    .border(viewModelScanner.showSheet ? Color.green : Color.black, width: 4)
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.clear)
            }

            Button {
                viewModelScanner.showSheet = true
            } label: {
                Text("Scan")
            }
        }
        .onAppear {
            Task {
                 await viewModelScanner.getScannedProducts()
           }
        }
        .sheet(isPresented: $viewModelScanner.showSheet) {
            VStack {
                if viewModelScanner.isLoading {
                    
                    ProgressView("Lädt Produkt...")
                
                } else if let product = viewModelScanner.scannedProduct?.product {
                    VStack {
                        AsyncImage(url: URL(string: product.image_url ?? "No URL Found")) { pic in
                            pic
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                        
                        Text("Product Name: \(product.product_name_de ?? "Unkown")")
                        Text("Ingredients: \(product.ingredients_text_de ?? "")")
                        Text("Allergens: \(product.allergens_imported ?? "")")
                        Text("Recyclable: \(product.labels ?? "")")
                        Text("Recyclable: \(product.packaging ?? "")")
                        Text("Footprint: \(product.carbon_footprint ?? "")")
                        Text("NutriScore Grade: \(product.nutriscore_grade ?? "")")
                        Text("Eco Score: \(product.ecoscore_score ?? 0)")
                        
                        AsyncImage(url: URL(string: product.image_nutrition_url ?? "No URL Found")) { pic in
                            pic
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                    }

                } else {
                    Text("Kein Produkt gefunden")
                }
            }
        }
    }
}

#Preview {
    ScannerView(viewModelScanner: ScannerViewModel())
}
