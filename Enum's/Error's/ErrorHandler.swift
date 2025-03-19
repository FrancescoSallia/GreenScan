//
//  ErrorHandler.swift
//  GreenScan
//
//  Created by Francesco Sallia on 19.03.25.
//

import Foundation


class ErrorHandler: ObservableObject {
    
    static let shared = ErrorHandler()
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    func handleError(error: ErrorEnum) {
        errorMessage = error.errorDescription ?? "Unbekannter Fehler"
        showError = true
    }
}
