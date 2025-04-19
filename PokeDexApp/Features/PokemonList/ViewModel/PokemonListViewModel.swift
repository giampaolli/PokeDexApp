//
//  PokemonListViewModel.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import Foundation

@MainActor
final class PokemonListViewModel: PokemonListViewModelProtocol {
  @Published var pokemons: [PokemonEntity] = []
  @Published var isLoading: Bool = false
  @Published var errorMessage: String? = nil
  
  private let fetchPokemonListUseCase: FetchPokemonListUseCaseProtocol
  
  init(fetchPokemonListUseCase: FetchPokemonListUseCaseProtocol) {
    self.fetchPokemonListUseCase = fetchPokemonListUseCase
  }
  
  func fetchPokemons() async {
    isLoading = true
    errorMessage = nil
    
    do {
      let pokemons = try await fetchPokemonListUseCase.execute()
      self.pokemons = pokemons.results
    } catch {
      errorMessage = error.localizedDescription
    }
    
    isLoading = false
  }
}


