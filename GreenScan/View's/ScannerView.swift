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
    @ObservedObject var errorHandler: ErrorHandler = .shared
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.costumBackground
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        CodeScannerView(codeTypes: [.ean8, .ean13, .aztec], scanMode: .once) { result in
                            
                            switch result {
                            case .success(let code):
                                viewModelScanner.isScanning = true
                                viewModelScanner.scannedBarcode = code.string  // Neuen Barcode speichern
                                print("ScannedProdukt from ScannedBarcode: \(viewModelScanner.scannedBarcode)")
                                viewModelScanner.isLoading = true   // Ladezustand anzeigen
                                Task {
                                    await viewModelScanner.getScannedProducts()
                                    
                                    if let scannedProduct = viewModelScanner.scannedProduct, scannedProduct.status == 1 {
                                        
                                        context.insert(scannedProduct)  // Richtiges Speichern
                                        try? context.save()
                                        
                                    } else {
                                        errorHandler.showError = true
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
                            .frame(width: 270, height: 150)
                            .foregroundStyle(.clear)
                    }
                    
                    .navigationDestination(isPresented: $viewModelScanner.navigateToDetailView) {
                        if let detailProduct = viewModelScanner.productDetail {
                            
                            if detailProduct.status == 1 {
                                ScannedProductDetail(viewModelScanner: viewModelScanner, product: detailProduct.product)
                            } else if detailProduct.status == 0 {
                                ZStack {
                                    Color.costumBackground
                                        .ignoresSafeArea()
                                    EmptyView()
                                        .toolbarVisibility(.hidden, for: .automatic)
                                }
                                .navigationBarBackButtonHidden(true)
                                .toolbarVisibility(.hidden, for: .tabBar)
                                .onAppear {
                                    errorHandler.errorMessage = "\(detailProduct.status_verbose ?? "Kein Produkt gefunden")"
                                    errorHandler.showError = true
                                }
                            } else {
                                ZStack {
                                    Color.costumBackground
                                        .ignoresSafeArea()
                                    EmptyView()
                                        .toolbarVisibility(.hidden, for: .automatic)
                                }
                                .navigationBarBackButtonHidden(true)
                                .toolbarVisibility(.hidden, for: .tabBar)
                                .onAppear {
                                    errorHandler.showError = true
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Scanner")
            .toolbarVisibility(.hidden, for: .automatic)

        }
        .alert(isPresented: $errorHandler.showError) {
            Alert(
                title: Text("Error"),
                message: Text(errorHandler.errorMessage),  // Holt die gespeicherte Fehlermeldung
                dismissButton: .default(Text("OK")) {
                    viewModelScanner.navigateToDetailView = false
                    viewModelScanner.productDetail = nil
                }
            )
        }
    }
}

#Preview {
    ScannerView(viewModelScanner: ScannerViewModel())
}
