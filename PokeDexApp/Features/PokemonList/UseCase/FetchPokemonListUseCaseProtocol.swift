//
//  FetchPokemonListUseCaseProtocol.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//
import Foundation

protocol FetchPokemonListUseCaseProtocol {
  func execute() async throws -> PokemonListResponse
}
