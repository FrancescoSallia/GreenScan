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
    @State private var editableProducts: [ScannedProduct] = []
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.costumBackground
                    .ignoresSafeArea()
                HStack {
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
            }
            .frame(maxWidth: .infinity, maxHeight: 52)
            ZStack {
                Color.costumBackground
                    .ignoresSafeArea()
                .padding()
                VStack {
                    
                    ZStack {
                        Color.costumBackground
                            .ignoresSafeArea()
                        
                        List {
                            ForEach(editableProducts.reversed(), id: \.id) { item in
                                ZStack {
                                    Color.costumBackground
                                    NavigationLink {
                                        ScannedProductDetail(viewModelScanner: viewModelScanner, product: item.product)
                                    } label: {
                                        
                                        HStack {
                                            
                                            AsyncImage(url: URL(string: item.product?.image_url ?? "https://fakeimg.pl/650x400/ffffff/000000?text=No+Food+Image")) { pic in
                                                
                                                pic
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(maxWidth: 120, maxHeight: 200)
                                                    .clipShape(.rect(cornerRadius: 15))
                                                
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
                                                    Button {
                                                        //placeholder
                                                    } label: {
                                                        Image(systemName: "heart")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .foregroundStyle(.black)
                                                            .frame(maxWidth: 30)
                                                            .padding(.top)
                                                    }
                                                }
                                            }
                                            .frame(maxWidth: 200)
                                            .foregroundStyle(.black)
                                        }
                                        .padding()
                                    }
                                }
                            }
                            .onDelete { offset in
                                for index in offset {
                                    let deleteItem = editableProducts[index]
                                    context.delete(deleteItem)
                                    try? context.save()
                                }
                            }
                            
                            .listRowBackground(Color.clear)
                        }
                        .toolbar {
                            Button {
                                for item in editableProducts {
                                    context.delete(item)
                                   try? context.save()
                                }
                                Task {
                                    editableProducts = products
                                }
                            } label: {
                                Text("Alles Löschen")
                            }
                        }
                        .background(Color.costumBackground)
                        .frame(maxHeight: 630)
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
        }
        .onAppear {
            editableProducts = products
        }
    }

}
//#Preview {
//    ListsView(viewModelScanner: ScannerViewModel())
//}
