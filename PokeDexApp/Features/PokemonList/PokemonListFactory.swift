//
//  PokemonListFactory.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

protocol PokemonListFactoryProtocol {
  associatedtype ViewModel: PokemonListViewModelProtocol
  @MainActor func makeViewModel() -> ViewModel
}


struct PokemonListFactory: PokemonListFactoryProtocol {
  @MainActor
  func makeViewModel() -> PokemonListViewModel {
    let apiClient = APIClient()
    let repository = PokemonRepositoryImpl(apiClient: apiClient)
    let useCase = FetchPokemonListUseCase(repository: repository)
    return PokemonListViewModel(fetchPokemonListUseCase: useCase)
  }
}
