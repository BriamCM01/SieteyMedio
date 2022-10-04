//
//  Mano.swift
//  SieteyMedio
//
//  Created by Briam Cano Marquez on 03/10/22.
//

import Foundation

class Mano {
    var cartas: [Carta?] = []
    var tamaño: Int {
        return cartas.count
    }
    
    func addCarta(carta: Carta?) {
        cartas.append(carta)
    }
    
    func getCarta(posicion: Int) -> Carta? {
        if posicion < 0 || posicion >= cartas.count {
            return nil
        } else {
            return cartas[posicion]
        }
    }
}
