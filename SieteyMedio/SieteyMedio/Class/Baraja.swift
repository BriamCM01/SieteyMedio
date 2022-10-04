//
//  Baraja.swift
//  SieteyMedio
//
//  Created by Briam Cano Marquez on 03/10/22.
//

import Foundation

class Baraja {
    var cartas: [Carta] = []
    
    init() {
        for palo in [Palo.bastos, Palo.espadas, Palo.copas, Palo.oros] {
            for valor in 1...12 {
                if valor != 8 && valor != 9 {  //El 8 y el 9 no se suelen usar
                    //Aquí crearíais la nueva carta y la añadiríais al array "cartas"
                    var newCarta = Carta(valor: valor, palo: palo)
                    guard let cartanew = newCarta else { return }
                    self.cartas.append(cartanew)
                }
            }
        }
    }
    
    func repartirCarta() -> Carta? {
        
        cartas.popLast()
        
    }
    
    func barajar() {
        cartas.shuffle()
    }
}
