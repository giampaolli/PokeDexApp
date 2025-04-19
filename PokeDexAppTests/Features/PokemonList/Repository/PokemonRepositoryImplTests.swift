//
//  PokemonRepositoryImplTests.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 19/04/25.
//

import XCTest
@testable import PokeDexApp

class PokemonRepositoryImplTests: XCTestCase {
  
  var mockAPIClient: MockAPIClient!
  var repository: PokemonRepositoryImpl!
  
  override func setUp() {
    super.setUp()
    mockAPIClient = MockAPIClient()
    repository = PokemonRepositoryImpl(apiClient: mockAPIClient)
  }
  
  override func tearDown() {
    mockAPIClient = nil
    repository = nil
    super.tearDown()
  }
  
  func testFetchPokemonList_Success() async throws {
    // Arrange
    // Suponha que você tenha uma instância de PokemonListResponse
    let pokemonList = PokemonListResponse(count: 1, next: nil, previous: nil, results: [
      PokemonEntity(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")
    ])
    
    // Usar JSONEncoder para converter para Data
    do {
      let encoder = JSONEncoder()
      let data = try encoder.encode(pokemonList)
      mockAPIClient.mockResponse = data
      
      // Agora a variável 'data' contém a representação binária (Data) da sua estrutura PokemonListResponse.
      print("Data converted successfully: \(data)")
      
      // Se você precisar ver os dados como uma string JSON para depuração, pode usar:
      if let jsonString = String(data: data, encoding: .utf8) {
        print("JSON string: \(jsonString)")
      }
    } catch {
      print("Error encoding PokemonListResponse: \(error)")
    }
    
    // Act
    let response = try await repository.fetchPokemonList()
    
    // Assert
    XCTAssertEqual(response.results.count, 1)
    XCTAssertEqual(response.results.first?.name, "Pikachu")
  }
  
  func testFetchPokemonList_Failure() async throws {
    // Arrange
    mockAPIClient.mockError = NSError(domain: "APIError", code: 0, userInfo: nil)
    
    // Act & Assert
    do {
      _ = try await repository.fetchPokemonList()
      XCTFail("Expected error but got success")
    } catch {
      XCTAssertNotNil(error)
    }
  }
}
