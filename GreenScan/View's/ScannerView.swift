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
    @State var showErrorAlert: Bool = false
    
    
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
                            if detailProduct.status == 1 {
                                
                                ScannedProductDetail(viewModelScanner: viewModelScanner, product: detailProduct.product)
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
                                    showErrorAlert.toggle()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Scanner")
            .toolbarVisibility(.hidden, for: .automatic)

        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Fehler beim Scannen vom Produkt"), message: Text("\(viewModelScanner.productDetail?.status_verbose ?? "Kein Produkt gefunden")"), dismissButton: .default(Text("Verstanden")) {
                viewModelScanner.navigateToDetailView = false  // Zurück zur vorherigen Ansicht
                viewModelScanner.productDetail = nil
            })
                
        }
    }
}

#Preview {
    ScannerView(viewModelScanner: ScannerViewModel())
}
