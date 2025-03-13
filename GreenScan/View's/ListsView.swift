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

    var body: some View {
        
        HStack(alignment: .top) {
            Picker("Sortieren nach", selection: .constant("Verlauf")) {
                Text("Verlauf").tag("Verlauf")
                Text("Favoriten").tag("Absteigend")
            }
            .pickerStyle(.segmented)
            .padding()
            
        }
        
//        ForEach(0 ..< 5) { item in
//            HStack {
//                Image("blatt")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxWidth: 120, maxHeight: 170)
//                    .padding(.horizontal)
//                
//                VStack {
//                    HStack {
//                        Text("Produkt-Name")
//                    }
//                    .padding()
//                    
//                    HStack {
//                        Text("Nutri-Score: ")
//                        Text("A")
//                            .textCase(.uppercase)
//                            .font(.callout)
//                            .foregroundStyle(.green)
//                    }
//                    .padding()
//                }
//            }
//        }

          
            List(viewModelScanner.scannedList.indices, id: \.hashValue) { item in
                
                ZStack {
                    Image("blatt")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Zentrierung
                        .opacity(0.3)
                        .ignoresSafeArea()

                
                let product = viewModelScanner.scannedList[item].product
                
                    HStack {
                        AsyncImage(url: URL(string: product?.image_url ?? "https://fakeimg.pl/650x400/ffffff/000000?text=No+Food+Image")) { pic in
                            
                            pic
                             .resizable()
                             .scaledToFit()
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
                    }

            }
             .frame(maxHeight: 200)

         
        }
        
   
        
    }
}
#Preview {
    ListsView(viewModelScanner: ScannerViewModel())
}
