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
    var body: some View {
        
        Picker("Sortieren nach", selection: .constant("Verlauf")) {
            Text("Verlauf").tag("Verlauf")
            Text("Favoriten").tag("Absteigend")
        }
        .pickerStyle(.segmented)
        .padding()
        
        
        
        
        
        
        
        
        
    }
}
#Preview {
    ListsView()
}
