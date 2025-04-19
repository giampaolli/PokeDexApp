//
//  PokemonListView.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import SwiftUI

struct PokemonListView<Factory: PokemonListFactoryProtocol>: View {
  @StateObject private var viewModel: Factory.ViewModel
  private let factory: Factory
  
  init(factory: Factory) {
    self.factory = factory
    _viewModel = StateObject(wrappedValue: factory.makeViewModel())
  }
  
  var body: some View {
    NavigationView {
      List(viewModel.pokemons, id: \.name) { pokemon in
        Text(pokemon.name)
      }
      .task {
        await viewModel.fetchPokemons()
      }
    }
  }
}
