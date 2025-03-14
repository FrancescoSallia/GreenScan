//
//  ListsView.swift
//  GreenScan
//
//  Created by Francesco Sallia on 11.03.25.
//

import SwiftUI
import CodeScanner

struct ListsView: View {
    
    @ObservedObject var viewModelScanner: ScannerViewModel
    @State private var selectedTab: String = "Verlauf"
    var body: some View {
        
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
                                  
                    List(viewModelScanner.scannedList.indices, id: \.hashValue) { item in

                        let product = viewModelScanner.scannedList[item].product
    
                        ZStack {
                            Color.costumBackground
                                .ignoresSafeArea()
                            VStack {
                                HStack {
                                    AsyncImage(url: URL(string: product?.image_url ?? "https://fakeimg.pl/650x400/ffffff/000000?text=No+Food+Image")) { pic in
                                        
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
                                            Text("\(product?.product_name_de ?? "")")
                                        }
                                        .padding(.bottom)
                                        HStack {
                                            Text("Nutri-Score: ")
                                            Text("\(product?.nutriscore_grade ?? "")")
                                                .textCase(.uppercase)
                                                .font(.callout)
                                                .foregroundStyle(viewModelScanner.nutriScoreGradient(product?.nutriscore_grade ?? ""))
                                        }
                                        .padding(.top)
                                        
                                    }
                                    .foregroundStyle(.black)
                                }
                                Divider()
                            }
                            .frame(maxHeight: 160)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.costumBackground) // Hintergrund für jede Zeile setzen
                }
                .scrollContentBackground(.hidden)
                .background(Color.costumBackground) // Setzt die neue Hintergrundfarbe
                 .frame(maxHeight: 620)
            }
        }
    }
}
#Preview {
    ListsView(viewModelScanner: ScannerViewModel())
}
