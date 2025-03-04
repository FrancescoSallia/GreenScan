//
//  ErrorEnum.swift
//  GreenScan
//
//  Created by Francesco Sallia on 04.03.25.
//

import Foundation

enum ErrorEnum: LocalizedError {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case noProducts
    case emailAlreadyInUse
    case weakPassword
    case unknownError
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .custom(let message):
            return message
        case .invalidURL:
            return "Invalid URL"
        default:
            return nil
        }
    }
}
