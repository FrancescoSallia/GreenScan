//
//  ScannedProductSheet.swift
//  GreenScan
//
//  Created by Francesco Sallia on 15.03.25.
//

import SwiftUI

struct ScannedProductDetail: View {
    
    @ObservedObject var viewModelScanner: ScannerViewModel
    var product: Product?
    
    var body: some View {
                    
//        NavigationView {
            ZStack {
                Color.costumBackground
                    .ignoresSafeArea()
                VStack {
                    if viewModelScanner.isLoading {
                        
                        ProgressView("Lädt Produkt...")
                        
                    } else if product != nil {
                        
                        ScrollView {
                            TabView {
                                AsyncImage(url: URL(string: product?.image_url ?? "https://fakeimg.pl/650x400/ffffff/000000?text=No+Food+Image")) { pic in
                                    pic
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 300, height: 300)
                                    
                                } placeholder: {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                                
                                AsyncImage(url: URL(string: product?.image_nutrition_url ?? "https://fakeimg.pl/650x400/ffffff/000000?text=No+Food+Image")) { pic in
                                    pic
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 300, height: 300)
                                    
                                } placeholder: {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .always))
                            .frame(height: 300)
                            .padding()
                            VStack {
                                
                                HStack {
                                    Text("Nutri-Score:")
                                        .textCase(.uppercase)
                                    Spacer()
                                    HStack {
                                        Text("\(SmileyEnum.smileyFromNutriScore(product?.nutriscore_grade?.uppercased() ?? "?").rawValue)")
                                        Text("(\(product?.nutriscore_grade?.uppercased() ?? "?"))")
                                    }
                                }
                                .padding()
                                .bold()
                                
//                                HStack {
//                                    Text("Eco Score:")
//                                        .textCase(.uppercase)
//                                    Spacer()
//                                    Text("\(product?.ecoscore_score ?? 0)")
//                                        .padding()
//                                    ProgressView(value: Double(product?.ecoscore_score ?? 0) / 100)
//                                        .tint(viewModelScanner.getColor(value: Double(product?.ecoscore_score ?? 0)))
//                                        .padding()
//                                    
//                                }
//                                .padding()
//                                .bold()
//                                .padding(.bottom, 40)
                                
                                HStack {
                                    Gauge(value: Double(product?.ecoscore_score ?? 0), in: 0...100) {
                                        Text("Eco Score:")
                                            .textCase(.uppercase)
                                            .bold()
                                    } currentValueLabel: {
//                                                Image(systemName: "face.smiling")
                                        Text("\(product?.ecoscore_score ?? 0) %")
                                            .foregroundStyle(.black)
//                                                    .frame(width: 80, height: 70)
                                            }
                                            .gaugeStyle(.linearCapacity)
                                            .tint(viewModelScanner.getColor(value: Double(product?.ecoscore_score ?? 0)))
                                            .frame(maxWidth: .infinity, maxHeight: 70)
                                            .padding()
                                }
                                
                                HStack {
                                    Text("Vegan:")
                                    Spacer()
                                    
                                    if let index = product?.ingredients?.firstIndex(where: { $0.vegan == "yes" || $0.vegan == "no" || $0.vegan == nil }) {
                                        
                                        let filteredProductVegan = product?.ingredients?[index].vegan ?? "?"
                                        
                                        if filteredProductVegan == "yes" {
                                            Image("blatt")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35, height: 35)
                                        } else if filteredProductVegan == "no" {
                                            
                                            Image("NoVegan")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35, height: 35)
                                        }
                                        
                                        Text("\(filteredProductVegan)")
                                    }
                                }
                                .padding()
                                
                                HStack {
                                    Text("Vegetarisch:")
                                    Spacer()
                                    Text("\(product?.ingredients?[0].vegetarian ?? "?")")
                                }
                                .padding()
                                
                                
                                HStack {
                                    Text("Name vom Produkt:")
                                    Spacer()
                                    Text("\(product?.product_name_de ?? "?")")
                                }
                                .padding()
                                
                                HStack {
                                    Text("Marke:")
                                    Spacer()
                                    Text("\(product?.brands ?? "?")")
                                }
                                .padding()
                                
                                HStack {
                                    Text("Zutaten:")
                                    Spacer()
                                    Text("\(product?.ingredients_text_de ?? "?")")
                                }
                                .padding()
                                
                                HStack {
                                    Text("Allergenen:")
                                    Spacer()
                                    Text("\(product?.allergens_imported ?? "?")")
                                }
                                .padding()
                                
                                Text("Nährwerte pro 100g:")
                                    .font(.title)
                                    .padding()
                                HStack {
                                    Text("Kalorien:")
                                    Spacer()
                                    Text("\(product?.nutriments?.energy_kcal_100g?.formatted() ?? 0.formatted()) kcal")
                                }
                                .padding()
                                
                                HStack {
                                    Text("Fett:")
                                    Spacer()
                                    Text("\(product?.nutriments?.fat_100g?.formatted() ?? 0.formatted()) g")
                                }
                                .padding()
                                
                                HStack {
                                    Text("Gesättigte Fette:")
                                    Spacer()
                                    Text("\(product?.nutriments?.saturated_fat_100g?.formatted() ?? 0.0.formatted()) g")
                                }
                                .padding()
                                
                                HStack {
                                    Text("Kohlenhydrate:")
                                    Spacer()
                                    Text("\(product?.nutriments?.carbohydrates_100g?.formatted() ?? 0.0.formatted()) g")
                                }
                                .padding()
                                
                                HStack {
                                    Text("Zucker:")
                                    Spacer()
                                    Text("\(product?.nutriments?.sugars_100g?.formatted() ?? 0.0.formatted()) g")
                                }
                                .padding()
                                
                                HStack {
                                    Text("Ballaststoffe:")
                                    Spacer()
                                    Text("\(product?.nutriments?.fiber_100g?.formatted() ?? 0.0.formatted()) g")
                                }
                                .padding()
                                
                                HStack {
                                    Text("Protein:")
                                    Spacer()
                                    Text("\(product?.nutriments?.proteins_100g?.formatted() ?? 0.formatted()) g")
                                }
                                .padding()
                                
                                HStack {
                                    Text("Salz:")
                                    Spacer()
                                    Text("\(product?.nutriments?.salt_100g?.formatted() ?? 0.0.formatted()) g")
                                }
                                .padding()
                                
                                Spacer()
                                
                            }
                        }
                        .frame(maxHeight: 655)
                    } else {
                        Text("(Kein Produkt gefunden)")
                    }
                }
                .background(Color.costumBackground)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    ScannedProductDetail(viewModelScanner: ScannerViewModel())
}
