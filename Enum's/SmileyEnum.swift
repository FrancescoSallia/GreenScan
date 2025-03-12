//
//  SmileyEnum.swift
//  GreenScan
//
//  Created by Francesco Sallia on 12.03.25.
//

import Foundation

enum SmileyEnum: String, CaseIterable {
    case happy = "🙂"
    case neutral = "🫤"
    case bad = "😐"
    case veryBad = "☹️"
    case unknown = "🤔"

    static func smileyFromNutriScore(_ score: String) -> SmileyEnum {  // static steht dafür, die funktion zu nutzen, ohne eine Instanz zu erstellen vom ganzen enum bspw.
           switch score.uppercased() {
           case "A", "B": return .happy
           case "C": return .neutral
           case "D": return .bad
           case "E": return .veryBad
           default: return .unknown
           }
       }
}

