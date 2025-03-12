//
//  ListsView.swift
//  GreenScan
//
//  Created by Francesco Sallia on 11.03.25.
//

import SwiftUI
import CodeScanner

struct ListsView: View {
    
//    var scannedProduct: Result<ScanResult, ScanError>
    @ObservedObject var viewModelScanner: ScannerViewModel

    var body: some View {
        
        HStack(alignment: .top){
            Picker("Sortieren nach", selection: .constant("Verlauf")) {
                Text("Verlauf").tag("Verlauf")
                Text("Favoriten").tag("Absteigend")
            }
            .pickerStyle(.segmented)
            .padding()
            
        }
        
        List(viewModelScanner.scannedList.indices, id: \.hashValue) { item in
            let product = viewModelScanner.scannedList[item].product
            HStack {
//                Image(systemName: "square.and.arrow.down.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 100, height: 120)
                
                AsyncImage(url: URL(string: product?.image_url ?? "No URL")) { pic in
                                pic
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 180)
                
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(.circular)
                            }
                
                VStack {
                    Text("\(product?.product_name_de ?? "No Name")" )
                    Text("\(product?.nutriscore_grade ?? "No Score")" )
                }
                
                
                
            
                
            }
        }
        
        
        
        
        
        
        
        
    }
}
#Preview {
    ListsView(viewModelScanner: ScannerViewModel())
}
