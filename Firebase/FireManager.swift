//
//  FireManager.swift
//  GreenScan
//
//  Created by Francesco Sallia on 11.03.25.
//

import Foundation
import FirebaseFirestore


class FireManager {
    
    static let shared = FireManager()
   
    // Es ist nicht mehr möglich, eine eigene Instanz von der Klasse zu erstellen, sondern man muss sich immer die shared Instanz holen.
    private init() {}
    
    
}
