//
//  DrinksBD+CoreDataProperties.swift
//  practica4
//
//  Created by Francisco Jaime on 07/04/22.
//
//

import Foundation
import CoreData


extension DrinksBD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DrinksBD> {
        return NSFetchRequest<DrinksBD>(entityName: "DrinksBD")
    }

    @NSManaged public var image: String?
    @NSManaged public var directions: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var name: String?

}

extension DrinksBD : Identifiable {

}
