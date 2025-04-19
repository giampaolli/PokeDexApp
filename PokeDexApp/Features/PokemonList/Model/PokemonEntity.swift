//
//  PokemonEntity.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import Foundation

struct PokemonListResponse: Decodable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [PokemonEntity]
}

struct PokemonEntity: Decodable {
  let name: String
  let url: String
}
