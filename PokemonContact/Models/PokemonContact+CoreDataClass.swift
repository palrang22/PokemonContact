//
//  PokemonContact+CoreDataClass.swift
//  PokemonContact
//
//  Created by 김승희 on 7/17/24.
//
//

import Foundation
import CoreData

@objc(PokemonContact)
public class PokemonContact: NSManagedObject {
    public static let PokemonEntity = "PokemonContact"
    public enum Key {
        static let id = "id"
        static let name = "name"
        static let num = "num"
        static let img = "img"
    }
}
