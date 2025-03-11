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
            
            ScannerView(viewModelScanner: viewModelScanner)
        }
    }
}
