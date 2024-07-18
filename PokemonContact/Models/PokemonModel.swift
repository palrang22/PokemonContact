//
//  PokemonModel.swift
//  PokemonContact
//
//  Created by 김승희 on 7/16/24.
//

import Foundation

struct PokemonModel: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
}

struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
