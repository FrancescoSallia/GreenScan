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
    case custom(String)  // Benutzerdefinierte Nachricht

    // Initialisiert ErrorEnum aus einem Error-Typ
    init(from error: Error) {
        if let appError = error as? ErrorEnum {
            self = appError
        } else {
            self = .custom(error.localizedDescription)
        }
    }

    var errorDescription: String? {
        switch self {
        case .custom(let message):
            return message  // Gibt den benutzerdefinierten Fehlertext zurück
        case .invalidURL:
            return "Ungültige URL"
        case .networkError(let error):
            return "Netzwerkfehler: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Daten konnten nicht verarbeitet werden: \(error.localizedDescription)"
        case .noProducts:
            return "Keine Produkte gefunden"
        case .emailAlreadyInUse:
            return "Diese E-Mail wird bereits verwendet"
        case .weakPassword:
            return "Passwort ist zu schwach"
        case .unknownError:
            return "Ein unbekannter Fehler ist aufgetreten"
        }
    }
}
