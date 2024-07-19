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
    
    @NSManaged public var id: UUID?
    @NSManaged public var img: String?
    @NSManaged public var name: String?
    @NSManaged public var num: String?
    
    // 데이터 추가시 자동으로 UUID 생성
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }

}

extension PokemonContact : Identifiable {

}
