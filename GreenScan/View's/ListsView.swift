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
    @State var isDeleted: Bool = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.costumBackground
                    .ignoresSafeArea()
                
                
                HStack {
                    Text("Verlauf")
                        .font(.largeTitle)
                        .foregroundStyle(Color.black)
                    
                    Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.black)
                    
                    Spacer()
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
                                                    Text("\(item.product?.product_name_de ?? "")")
                                                }
                                                .padding(.bottom)
                                                HStack {
                                                    Text("Nutri-Score: ")
                                                    Text("\(viewModelScanner.isUnknownScore(value: item.product?.nutriscore_grade?.uppercased() ?? ""))")
                                                        .textCase(.uppercase)
                                                        .font(.callout)
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    Text("\(item.product?.status ?? "kein Status")")
                                                        .textCase(.uppercase)
                                                        .font(.callout)
                                                    
                                                    
                                                    
                                                }
                                            }
                                            .frame(maxWidth: 200)
                                            .foregroundStyle(.black)
                                            
                                        }
                                        .padding()
                                        Divider()
                                        VStack {
                                            Text("\(viewModelScanner.isUnknownScore(value: item.product?.nutriscore_grade?.uppercased() ?? ""))")
                                                .textCase(.uppercase)
                                                .font(.largeTitle)
                                                .foregroundStyle(viewModelScanner.getNutriScoreColor(value: item.product?.nutriscore_grade?.uppercased() ?? ""))
                                        }
                                    }
                                }
                                Divider()
                            }
                            .onDelete { offset in
                                for index in offset {
                                    let originalIndex = editableProducts.count - 1 - index
                                    let deleteItem = editableProducts[originalIndex]
                                    context.delete(deleteItem)
                                    try? context.save()
                                }
                                editableProducts = products
                            }
                            
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden, edges: .all)
                            
                        }
                        .toolbar {
                            
                            Button {
                                guard !editableProducts.isEmpty else {
                                    return
                                }
                                isDeleted.toggle()
                                
                            } label: {
                                Text("Alles Löschen")
                            }
                        }
                        .background(Color.costumBackground)
                        .frame(maxHeight: 550)
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
        }
        .alert("Wirklich alle Einträge löschen?", isPresented: $isDeleted, actions: {
            Button("Nein") {
                
            }
            Button {
                withAnimation {
                    for item in editableProducts {
                        context.delete(item)
                       try? context.save()
                    }
                    
                    editableProducts = products
                }
                
            } label: {
                Text("Ja")
                    .foregroundStyle(.red)
            }
        })
        .onAppear {
            editableProducts = products
        }
    }
}
//#Preview {
//    ListsView(viewModelScanner: ScannerViewModel())
//}
