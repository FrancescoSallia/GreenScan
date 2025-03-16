//
//  ColorExtension.swift
//  GreenScan
//
//  Created by Francesco Sallia on 14.03.25.
//

import Foundation
import SwiftUICore
import UIKit

extension Color {
    static let costumBackground = Color(red: 255/255, green: 251/255, blue: 241/255)
    static let costumSelectedTab = Color(red: 130/255, green: 89/255, blue: 41/255)
}

extension UIColor {
    
    /// Erstellt eine Farbe aus einem Hex-Code
       convenience init(hex: String) {
           var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
           cleanedHex = cleanedHex.replacingOccurrences(of: "#", with: "")

           var rgb: UInt64 = 0
           Scanner(string: cleanedHex).scanHexInt64(&rgb)

           let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
           let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
           let blue = CGFloat(rgb & 0xFF) / 255.0

           self.init(red: red, green: green, blue: blue, alpha: 1.0)
       }
    /// Eigene benannte Farben
        static let themeGreen = UIColor(hex: "#4CAF50")
        static let themeBlue = UIColor(hex: "#2196F3")
        static let themeRed = UIColor(hex: "#F44336")
        static let themeCostumBackground = UIColor(hex: "#FFFBF1")
}
