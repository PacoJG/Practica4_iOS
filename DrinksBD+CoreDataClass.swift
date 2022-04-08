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
    
    func inicializaCon(_ dict: [String:String]){
        let image = (dict["image"]) ?? ""
        let directions = (dict["directions"]) ?? ""
        let ingredients = (dict["ingredients"]) ?? ""
        let name = (dict["name"]) ?? ""
        self.image = image
        self.directions = directions
        self.ingredients = ingredients
        self.name = name
    }

}
