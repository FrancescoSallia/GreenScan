//
//  GreenScanApp.swift
//  GreenScan
//
//  Created by Francesco Sallia on 04.03.25.
//

import SwiftUI
import FirebaseCore

@main
struct GreenScanApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject var viewModelScanner = ScannerViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Scanner", systemImage: "barcode.viewfinder") {
                    ScannerView(viewModelScanner: viewModelScanner)
                }
                Tab("Verlauf", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90") {
                    ListsView(viewModelScanner: viewModelScanner)
                }
            }
        }
    }
}
