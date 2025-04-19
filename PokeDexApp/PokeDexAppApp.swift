//
//  PokeDexAppApp.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import SwiftUI

@main
struct PokeAppApp: App {
  var body: some Scene {
    WindowGroup {
      PokemonListView(factory: PokemonListFactory())
    }
  }
}
