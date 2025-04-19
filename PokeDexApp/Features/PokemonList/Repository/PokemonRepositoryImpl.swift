//
//  PokemonRepositoryImpl.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import Foundation

final class PokemonRepositoryImpl: PokemonRepository {
  private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchPokemonList() async throws -> PokemonListResponse {
        try await apiClient.request(.pokemonList)
    }
}

