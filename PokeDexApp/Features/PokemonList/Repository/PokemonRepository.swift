//
//  PokemonRepository.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import Foundation

protocol PokemonRepository {
  func fetchPokemonList() async throws -> PokemonListResponse
}
