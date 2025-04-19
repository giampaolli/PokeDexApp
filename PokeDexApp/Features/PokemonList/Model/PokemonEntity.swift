//
//  PokemonEntity.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import Foundation

struct PokemonListResponse: Codable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [PokemonEntity]
  
  init(count: Int, next: String?, previous: String?, results: [PokemonEntity]) {
    self.count = count
    self.next = next
    self.previous = previous
    self.results = results
  }
}

struct PokemonEntity: Codable {
  let name: String
  let url: String
  
  init(name: String, url: String) {
    self.name = name
    self.url = url
  }
}
