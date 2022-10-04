//
//  Carta.swift
//  SieteyMedio
//
//  Created by Briam Cano Marquez on 03/10/22.
//

import Foundation

class Carta {
    var value: Int
    var palo: Palo
    
    init?(valor: Int, palo: Palo) {
        if valor != 9 && valor != 8 {
            self.value = valor
            self.palo = palo
        } else {
            return nil
        }
    }
    
    func description() -> String {
        return palo.rawValue
    }
}
