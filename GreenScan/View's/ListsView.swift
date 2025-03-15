//
//  ListsView.swift
//  GreenScan
//
//  Created by Francesco Sallia on 11.03.25.
//

import SwiftUI
import CodeScanner
import SwiftData

struct ListsView: View {
    
    @ObservedObject var viewModelScanner: ScannerViewModel
    @Environment(\.modelContext) var context
    @State private var selectedTab: String = "Verlauf"
    @Query private var products: [ScannedProduct]
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.costumBackground
                    .ignoresSafeArea()
                VStack {
                    HStack() {
                        Text("Verlauf")
                            .padding(.vertical, 8)
                            .frame(maxWidth: 200)
                            .background(selectedTab == "Verlauf" ? Color.costumSelectedTab : Color.clear)
                            .foregroundStyle(selectedTab == "Verlauf" ? Color.costumBackground : Color.costumSelectedTab)
                            .clipShape(.buttonBorder)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    selectedTab = "Verlauf"
                                }
                            }
                        
                        Text("Favoriten")
                            .padding(.vertical, 8)
                            .frame(maxWidth: 200)
                            .background(selectedTab == "Favoriten" ? Color.costumSelectedTab : Color.clear)
                            .foregroundStyle(selectedTab == "Favoriten" ? Color.costumBackground : Color.costumSelectedTab)
                            .clipShape(.buttonBorder)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    selectedTab = "Favoriten"
                                }
                            }
                    }
                    .padding()
                    
                    List(products.reversed(), id: \.id) { item in
                        NavigationLink {
                            ScannedProductSheet(viewModelScanner: viewModelScanner, product: item.product)
                               
                        } label: {
                            
                            ZStack {
                                Color.costumBackground
//                                    .ignoresSafeArea()
                                VStack {
                                    HStack {
                                        AsyncImage(url: URL(string: item.product?.image_url ?? "https://fakeimg.pl/650x400/ffffff/000000?text=No+Food+Image")) { pic in
                                            
                                            pic
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 15))
                                            //                             .frame(maxWidth: 120, maxHeight: 150)
                                                .padding(.horizontal)
                                            
                                        } placeholder: {
                                            ProgressView()
                                                .progressViewStyle(.circular)
                                        }
                                        
                                        VStack {
                                            HStack {
                                                //                            Text("Produkt Name:")
                                                Text("\(item.product?.product_name_de ?? "")")
                                            }
                                            .padding(.bottom)
                                            HStack {
                                                Text("Nutri-Score: ")
                                                Text("\(item.product?.nutriscore_grade ?? "")")
                                                    .textCase(.uppercase)
                                                    .font(.callout)
                                                    .foregroundStyle(viewModelScanner.nutriScoreGradient(item.product?.nutriscore_grade ?? ""))
                                            }
                                            .padding(.top)
                                            
                                        }
                                        .foregroundStyle(.black)
                                    }
                                    Divider()
                                }
                                .frame(maxHeight: 160)
                            }
                            .background(Color.costumBackground)
                            .listRowBackground(Color.costumBackground) // Hintergrund für jede Zeile setzen
                            .listRowSeparator(.hidden)
                            
                            .swipeActions(content: {
                                
                                Button(role: .destructive) {
                                    context.delete(item)
                                    try? context.save()
                                } label: {
                                    Image(systemName: "trash")
                                }
                            })
                        }
                        .background(Color.costumBackground) // Setzt die neue Hintergrundfarbe
                    }
                    .scrollContentBackground(.hidden)
                    .frame(maxHeight: 620)
                }
            }
        }
    }
}
#Preview {
    ListsView(viewModelScanner: ScannerViewModel())
}
