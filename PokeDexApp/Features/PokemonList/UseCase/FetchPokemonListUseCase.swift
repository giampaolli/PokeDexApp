//
//  FetchPokemonListUseCase.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import Foundation

final class FetchPokemonListUseCase: FetchPokemonListUseCaseProtocol {
  private let repository: PokemonRepository
  
  init(repository: PokemonRepository) {
    self.repository = repository
  }
  
  func execute() async throws -> PokemonListResponse {
    try await repository.fetchPokemonList()
  }
}

