//
//  PokemonListViewModelProtocol.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import Foundation
import SwiftUI

@MainActor
protocol PokemonListViewModelProtocol: ObservableObject {
  var pokemons: [PokemonEntity] { get }
  var isLoading: Bool { get }
  var errorMessage: String? { get }
  func fetchPokemons() async
}
