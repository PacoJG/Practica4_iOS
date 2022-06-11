//
//  ViewController.swift
//  practica3
//
//  Created by Francisco Jaime on 28/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageDrink: UIImageView!
    @IBOutlet weak var nameDrink: UILabel!
    @IBOutlet weak var ingredientesDrink: UITextView!
    @IBOutlet weak var instruccionesDrink: UITextView!
    var detalle_drink = DrinksBD()

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameDrink.text = detalle_drink.name
        let tmpimage = detalle_drink.image ?? ""
        let pre_imageDrink = UIImage(named: tmpimage.lowercased()) ?? UIImage()
        imageDrink.image = pre_imageDrink
        ingredientesDrink.text = detalle_drink.ingredients
        instruccionesDrink.text = detalle_drink.directions
    }
    
    @IBAction func btnCompartir(_ sender: Any) {
        print("Compartir")
        let imageDrink:UIImage = imageDrink.image!
        let paraCompartir:[Any] = [ imageDrink, detalle_drink.name!]
        let ac = UIActivityViewController(activityItems:paraCompartir, applicationActivities: nil)
        self.present(ac, animated: true)
    }


}

