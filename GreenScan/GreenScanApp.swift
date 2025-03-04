//
//  GreenScanApp.swift
//  GreenScan
//
//  Created by Francesco Sallia on 04.03.25.
//

import SwiftUI

@main
struct GreenScanApp: App {
    
    @StateObject var viewModelScanner = ScannerViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            ContentView(viewModelScanner: viewModelScanner)
        }
    }
}
