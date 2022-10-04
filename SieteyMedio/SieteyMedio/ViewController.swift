//
//  ViewController.swift
//  SieteyMedio
//
//  Created by Briam Cano Marquez on 03/10/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var btnPlantarse: UIButton!
    @IBOutlet weak var btnPedirCarta: UIButton!
    
    let juego = Juego()
    var vistasCartas : [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        seeCard()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(setUI),
                                       name: Notification.Name("isActive"),
                                       object: nil)
    
    }
   @objc func setUI(isActive: Bool) {
        btnPlantarse.isEnabled = isActive
        btnPedirCarta.isEnabled = isActive
       showAlert()
    }
    @IBAction func pedirCarta(_ sender: Any) {
        juego.jugadorPideCarta()
        for carta in 0..<juego.manoJugador.cartas.count  {
            if  let mySum = juego.manoJugador.cartas[carta] {
                dibujarCarta(carta: mySum, posicion: carta)
            }
            
        }
        
    }
    @IBAction func plantarse(_ sender: Any) {
        juego.jugadorSePlanta()
    }
    @IBAction func nuevaPartida(_ sender: Any) {
        juego.comenzarPartida()
        btnPlantarse.isEnabled = true
        btnPedirCarta.isEnabled = true
        //Quitamos las cartas de la pantalla
        for vistaCarta in self.vistasCartas {
            vistaCarta.removeFromSuperview()
        }
        //ya no tenemos imágenes de cartas en pantalla, ponemos el array a vacío
        self.vistasCartas=[]
    }
    
    func showAlert() {
        if juego.estado == .pierdeJugador {
            let alert = UIAlertController(title: "Ganador", message: "Maquina Gana", preferredStyle: .alert)
            let actionA = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(actionA)
            present(alert, animated: true)
        } else if juego.estado == .ganaJugador {
            let alert = UIAlertController(title: "Ganador", message: "Jugador Gana", preferredStyle: .alert)
            let actionA = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(actionA)
            present(alert, animated: true)
        }
    }
    
    func dibujarCarta(carta: Carta, posicion : Int) {
        let nombreImagen = String(carta.palo.rawValue)
        let imagenCarta = UIImage(named: nombreImagen)
        let cartaView = UIImageView(image: imagenCarta)
        cartaView.frame = CGRect(x: 200, y: 200, width: 300, height: 400)
        cartaView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        self.view.addSubview(cartaView)
        self.vistasCartas.append(cartaView)
        UIView.animate(withDuration: 0.5){
            cartaView.frame = CGRect(x: 100 + 80 * (posicion - 1), y: 100, width: 125, height: 170);
            cartaView.transform = CGAffineTransform(rotationAngle:0);
        }
    }

    //    func seeCard() {
    //
    //
    //        var mano = Mano()
    //        DispatchQueue.main.async {
    //            mano.addCarta(carta: Carta(valor: 1, palo: .oros))
    //            mano.addCarta(carta: Carta(valor: 10, palo: .espadas))
    //            mano.addCarta(carta: Carta(valor: 7, palo: .copas))
    //
    //            print("Hay \(mano.tamaño) cartas")
    //            for num in 0..<mano.tamaño {
    //                if let carta = mano.getCarta(posicion: num) {
    //                    print(carta.description())
    //                }
    //            }
    //        }
    //    }
}

