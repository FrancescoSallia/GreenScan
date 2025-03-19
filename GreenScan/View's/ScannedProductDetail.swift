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
                                                                
                                HStack {
                                    Gauge(value: Double(product?.ecoscore_score ?? 0), in: 0...100) {
                                        Text("Eco Score:")
                                            .textCase(.uppercase)
                                            .bold()
                                    } currentValueLabel: {
                                        Text("\(product?.ecoscore_score ?? 0) %")
                                            .foregroundStyle(.black)
                                            }
                                            .gaugeStyle(.linearCapacity)
                                            .tint(viewModelScanner.getColor(value: Double(product?.ecoscore_score ?? 0)))
                                            .frame(maxWidth: .infinity, maxHeight: 70)
                                            .padding()
                                }
                                
                                HStack {
                                    Text("Name vom Produkt:")
                                    Spacer()
                                    Text("\(product?.product_name_de ?? "?")")
                                }
                                .padding(.horizontal)
                                
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
                                    Text("\(product?.allergens_imported ?? "\(product?.allergens_from_ingredients ?? "?")")")
                                }
                                .padding()
                                
                                Text("Verpackung")
                                    .font(.title)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.costumSelectedTab.opacity(0.3))
                                    .clipShape(.buttonBorder)
                                    .padding(.horizontal)
                                    .padding(.top, 40)
                                
                                VStack {

                                    if let packagings = product?.packagings {
                                        ForEach(packagings, id: \.id) { package in
                                            HStack {
                                                VStack(alignment: .leading, spacing: 26) {
                                                    Text("Material:")
                                                    Text("Umweltfreundliches Material:")
                                                    Text("Recycling:")
                                                    Text("Verpackungsform:")
                                                }
                                                Spacer()
                                                VStack(alignment: .trailing, spacing: 26) {
                                                    Text(package.material ?? "")
                                                    Text("\(package.environmental_score_material_score ?? 0) %")
                                                    Text(package.recycling ?? "")
                                                    Text(package.shape ?? "")
                                                }
                                            }
                                            Divider()
                                                .padding(.bottom)
                                        }
                                    } else {
                                        Text("No data available")
                                    }
                                }
                                .padding()
                                
                                Text("Nährwerte pro 100g:")
                                    .font(.title)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.costumSelectedTab.opacity(0.3))
                                    .clipShape(.buttonBorder)
                                    .padding(.horizontal)
                                    .padding(.top, 40)
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
                        
                        Text(viewModelScanner.scannedProduct?.status_verbose ?? "Keine Information")
                            .padding()
                        
                        // versuch das als ein alert dir anzeigen zu lassen!!
                     
                    }
                }
                .background(Color.costumBackground)
                .foregroundStyle(.black)
        }
    }
}

//#Preview {
//    let dummyProduct = Product(
//        id: "123456",
//        code: "4001234567890",
//        product_name_de: "Bio Apfelsaft",
//        ingredients_text_de: "100% Apfelsaft aus biologischem Anbau",
//        allergens_imported: "Keine",
//        allergens_from_ingredients: "Keine",
//        image_url: "https://fakeimg.pl/300x300/32CD32/FFFFFF?text=Apfelsaft",
//        image_nutrition_url: "https://fakeimg.pl/300x300/FFD700/000000?text=Nährwerte",
//        nutriments: Nutriments(
//            energy_kcal_100g: 46,
//            fat_100g: 0.1,
//            saturated_fat_100g: 0.02,
//            carbohydrates_100g: 11.0,
//            sugars_100g: 9.0,
//            fiber_100g: 1.2,
//            proteins_100g: 0.2,
//            salt_100g: 0.01
//        ),
//        nutriscore_grade: "A",
//        ecoscore_score: 85,
//        ingredients: [
//            Ingredient(vegan: "yes", vegetarian: "yes"),
//        ],
//        brands: "BioFarm",
//        packagings: [
//            Package(environmental_score_material_score: 92, material: "paperboard", recycling: "recycling", shape: "Box"),
//            Package
//        ]
//    )
//    ScannedProductDetail(viewModelScanner: ScannerViewModel(), product: dummyProduct)
//}
