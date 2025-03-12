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
    let gradient = LinearGradient(colors: [.brown.opacity(0.5), .green.opacity(0.5)], startPoint: .top, endPoint: .bottom)
    //    let gradient = LinearGradient(colors: [.brown.opacity(0.5), .orange.opacity(0.5)], startPoint: .top, endPoint: .bottom)
//    let gradient = LinearGradient(colors: [.brown.opacity(0.5), .red.opacity(0.5)], startPoint: .top, endPoint: .bottom)

    var body: some View {
        VStack {
            ZStack {
                CodeScannerView(codeTypes: [.qr, .ean8, .ean13, .aztec], scanMode: .continuous, scanInterval: 3.0) { result in
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
                    .frame(width: 270, height: 150)
                    .foregroundStyle(.clear)
            }

            Button {
                viewModelScanner.showSheet = true
            } label: {
                Text("Scan")
            }
        }
//        .onAppear {
//            Task {
//                 await viewModelScanner.getScannedProducts()
//           }
//        }
        .sheet(isPresented: $viewModelScanner.showSheet) {
            ZStack {
                
                gradient
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    if viewModelScanner.isLoading {
                        
                        ProgressView("Lädt Produkt...")
                        
                    } else if let product = viewModelScanner.scannedProduct?.product {
                        TabView {
                            AsyncImage(url: URL(string: product.image_url ?? "https://fakeimg.pl/650x400/ffffff/000000?text=No+Food+Image")) { pic in
                                pic
                                    .resizable()
                                    .scaledToFit()
                                
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(.circular)
                            }
                            
                            AsyncImage(url: URL(string: product.image_nutrition_url ?? "https://fakeimg.pl/650x400/ffffff/000000?text=No+Food+Image")) { pic in
                                pic
                                    .resizable()
                                    .scaledToFit()
                                
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(.circular)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .automatic))
                        .padding()
                        .frame(maxHeight: 200)
                        
                        ScrollView {
                         VStack {
                             
                             HStack {
                                 Text("Nutri-Score:")
                                     .textCase(.uppercase)
                                 Spacer()
                                 HStack {
                                     Text("\(SmileyEnum.smileyFromNutriScore(product.nutriscore_grade?.uppercased() ?? "No NutriScore").rawValue)")
                                     Text("(\(product.nutriscore_grade?.uppercased() ?? "No NutriScore"))")
                                 }
                             }
                             .padding()
                             .bold()
                             
                             HStack {
                                 Text("Eco Score:")
                                     .textCase(.uppercase)
                                 Spacer()
                                 Text("\(product.ecoscore_score ?? 0)")
                             }
                             .padding()
                             .bold()
                             .padding(.bottom, 70)
                             
                             HStack {
                                 Text("Vegan:")
                                     .textCase(.uppercase)
                                 Spacer()
                                 Text("\(product.ingredients[0]?.vegan ?? "No Vegan")")
                             }
                             .padding()
                             
                             HStack {
                                 Text("Vegetarian:")
                                     .textCase(.uppercase)
                                 Spacer()
                                 Text("\(product.ingredients[0]?.vegetarian ?? "No Vegan")")
                             }
                             .padding()
                             
                             
                            HStack {
                                Text("Product Name:")
                                Spacer()
                                Text("\(product.product_name_de ?? "Unkown")")
                            }
                            .padding()
                            
                            HStack {
                                Text("Ingredients:")
                                Spacer()
                                Text("\(product.ingredients_text_de ?? "")")
                            }
                            .padding()
                            
                            HStack {
                                Text("Allergens:")
                                Spacer()
                                Text("\(product.allergens_imported ?? "")")
                            }
                            .padding()
                            
                            Text("Nährwerte pro 100g:")
                                .font(.title)
                                .padding()
                            HStack {
                                Text("Kalorien:")
                                Spacer()
                                Text("\(product.nutriments?.energy_kcal_100g?.formatted() ?? 0.formatted()) kcal")
                            }
                            .padding()
                            
                            HStack {
                                Text("Fett:")
                                Spacer()
                                Text("\(product.nutriments?.fat_100g?.formatted() ?? 0.formatted()) g")
                            }
                            .padding()
                            
                            HStack {
                                Text("Gesättigte Fette:")
                                Spacer()
                                Text("\(product.nutriments?.saturated_fat_100g?.formatted() ?? 0.0.formatted()) g")
                            }
                            .padding()
                            
                            HStack {
                                Text("Kohlenhydrate:")
                                Spacer()
                                Text("\(product.nutriments?.carbohydrates_100g?.formatted() ?? 0.0.formatted()) g")
                            }
                            .padding()
                            
                            HStack {
                                Text("Zucker:")
                                Spacer()
                                Text("\(product.nutriments?.sugars_100g?.formatted() ?? 0.0.formatted()) g")
                            }
                            .padding()
                            
                            HStack {
                                Text("Ballaststoffe:")
                                Spacer()
                                Text("\(product.nutriments?.fiber_100g?.formatted() ?? 0.0.formatted()) g")
                            }
                            .padding()
                             
                             HStack {
                                Text("Protein:")
                                Spacer()
                                Text("\(product.nutriments?.proteins_100g?.formatted() ?? 0.formatted()) g")
                            }
                            .padding()
                            
                            HStack {
                                Text("Salz:")
                                Spacer()
                                Text("\(product.nutriments?.salt_100g?.formatted() ?? 0.0.formatted()) g")
                            }
                            .padding()
                            
                            Spacer()
                            
                        }
                    }
                    } else {
                        Text("(Keine Produkte gescannt)")
                    }
                }
            }
            }
    }
}

#Preview {
    ScannerView(viewModelScanner: ScannerViewModel())
}
