//
//  PokemonContact+CoreDataProperties.swift
//  PokemonContact
//
//  Created by 김승희 on 7/17/24.
//
//

import Foundation
import CoreData


extension PokemonContact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonContact> {
        return NSFetchRequest<PokemonContact>(entityName: "PokemonContact")
    }

    @NSManaged public var img: String?
    @NSManaged public var name: String?
    @NSManaged public var num: String?

}

extension PokemonContact : Identifiable {

}
