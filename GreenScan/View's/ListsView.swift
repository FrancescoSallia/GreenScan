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
        
        Picker("Sortieren nach", selection: .constant("Verlauf")) {
            Text("Verlauf").tag("Verlauf")
            Text("Favoriten").tag("Absteigend")
        }
        .pickerStyle(.segmented)
        .padding()
        
        VStack {
            
            AsyncImage(url: URL(string: viewModelScanner.scannedProduct?.product?.image_url ?? "No URL")) { pic in
                pic
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 180)
                
            } placeholder: {
                
                ProgressView()
                    .progressViewStyle(.circular)
            }

        }
        
        
        
        
        
        
        
        
        
    }
}
#Preview {
    ListsView(viewModelScanner: ScannerViewModel())
}
