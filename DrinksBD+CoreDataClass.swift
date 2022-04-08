//
//  DrinksBD+CoreDataClass.swift
//  practica4
//
//  Created by Francisco Jaime on 07/04/22.
//
//

import Foundation
import CoreData

@objc(DrinksBD)
public class DrinksBD: NSManagedObject {
    
    func inicializaCon(_ dict: [String:Any]){
        let image = (dict["image"] as? String) ?? ""
        let directions = (dict["directions"] as? String) ?? ""
        let ingredients = (dict["ingredients"] as? String) ?? ""
        let name = (dict["name"] as? String) ?? ""
        self.image = image
        self.directions = directions
        self.ingredients = ingredients
        self.name = name
    }

}
