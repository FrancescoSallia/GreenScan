//
//  GreenScanApp.swift
//  GreenScan
//
//  Created by Francesco Sallia on 04.03.25.
//

import SwiftUI
import SwiftData

@main
struct GreenScanApp: App {
    
    @StateObject var viewModelScanner = ScannerViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                Color.costumBackground
                    .ignoresSafeArea()
                TabView {
                    Tab("Scanner", systemImage: "barcode.viewfinder") {
                        ScannerView(viewModelScanner: viewModelScanner)
                            .modelContainer(for: [ScannedProduct.self])
                    }
                    Tab("Verlauf", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90") {
                        ListsView(viewModelScanner: viewModelScanner)
                            .modelContainer(for: [ScannedProduct.self])

                    }
                }
                .onAppear {
                    UITabBar.appearance().backgroundColor = .themeCostumBackground // Wechselt die hintergrundfarbe von der tabView
                }
                .tint(.costumSelectedTab)
            }
        }
    }
}
