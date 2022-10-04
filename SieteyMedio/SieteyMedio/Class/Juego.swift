//
//  Juego.swift
//  SieteyMedio
//
//  Created by Briam Cano Marquez on 03/10/22.
//

import Foundation
import UserNotifications
import UIKit

enum EstadoJuego {
    case turnoJugador, ganaJugador, pierdeJugador, empate, noIniciado
}

class Juego {
    var baraja : Baraja?
    var manoJugador : Mano!
    var estado : EstadoJuego
    var jugadaMaquina : Double = 0.0
    
    init() {
        self.estado = EstadoJuego.noIniciado
    }
    
    //LLamar a este método cuando se pulse el botón de "comenzar partida"
    func comenzarPartida() {
        self.baraja = Baraja()
        self.baraja?.barajar()
        
        self.manoJugador = Mano()
        jugadaMaquina = Double(Int.random(in: 1...7))
        //y luego el 50% de las veces le sumamos 0.5
        if (Bool.random()) {
            jugadaMaquina += 0.5
        }
    }
    
    //LLamar a este método cuando se pulse el botón de "Pedir carta"
    func jugadorPideCarta() {
        //            guard let pedida = self.baraja?.repartirCarta() else { return }
        let pedida = self.baraja?.repartirCarta()
        print("Sacas \(pedida?.description())")
        self.manoJugador?.addCarta(carta: pedida)
        let valorMano = self.sumarManoJugador()
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name("isCard"), object: nil)
        print("Llevas \(valorMano) puntos")
        if (valorMano > 7.5) {
            self.acabarPartida()
        }
    }
    
    //LLamar a este método cuando se pulse el botón de "Plantarse"
    func jugadorSePlanta() {
        acabarPartida()
    }
    
    func sumarManoJugador() -> Double {
        var manoJug = 0.0
        for sumMano in 0..<manoJugador.cartas.count {
            manoJug = 0.0
            if  let mySum = manoJugador.cartas[sumMano]?.value {
                manoJug = Double(mySum + mySum)
                manoJug = manoJug / 2
            }
        }
        
        print(manoJug)
        return manoJug
    }
    
    //Métodos para uso interno de la clase, no es necesario llamarlos desde fuera
    //Calcula quién gana, cambia el estado del juego y lo muestra en la consola con print
    private func acabarPartida() {
        let usDefault = UserDefaults.standard
        
        //TODO: sumar el valor de las cartas del jugador
        var manoJug = 0.0
        for sumMano in 0..<manoJugador.cartas.count {
            if let mySum = manoJugador.cartas[sumMano]?.value {
                manoJug = Double(mySum + mySum)
                manoJug = manoJug / 2
            }
        }
        
        print(manoJug)
        
        //TODO: calcular quién gana, en función de esta suma y la jugada de la máquina
        //TODO: cambiar el estado del juego al valor apropiado e imprimir un mensaje
        if manoJug < 7.5 && manoJug >= jugadaMaquina {
            print("Gana jugador")
            self.estado = EstadoJuego.ganaJugador
            
            usDefault.set("Gana Jugador", forKey: "jugador")
        } else {
            print("Gana Maquina")
            self.estado = EstadoJuego.pierdeJugador
            usDefault.set("Gana Maquina", forKey: "maquina")
        }
        
        //TODO: en la interfaz completa, enviar notificación al ViewController indicando que la partida ha terminado,
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name("isActive"), object: nil)
        
        //TODO: para que este habilite/deshabilite botones y muestre con un "alert" el resultado
    }
    
    
    
}
