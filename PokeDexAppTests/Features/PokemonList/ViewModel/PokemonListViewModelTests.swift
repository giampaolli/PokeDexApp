//
//  PokemonListViewModelTests.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 19/04/25.
//

import XCTest
import Combine
@testable import PokeDexApp

@MainActor
class PokemonListViewModelTests: XCTestCase {
  
  var viewModel: PokemonListViewModel!
  var mockUseCase: MockFetchPokemonListUseCase!
  
  override func setUp() {
    super.setUp()
    mockUseCase = MockFetchPokemonListUseCase()
    viewModel = PokemonListViewModel(fetchPokemonListUseCase: mockUseCase)
  }
  
  override func tearDown() {
    viewModel = nil
    mockUseCase = nil
    super.tearDown()
  }
  
  func testFetchPokemons_Success() async {
    // Arrange
    let expectedResponse = PokemonListResponse(count: 1, next: nil, previous: nil, results: [PokemonEntity(name: "Pikachu", url: "")])
    mockUseCase.mockResponse = expectedResponse
    
    // Act
    await viewModel.fetchPokemons()
    
    // Assert
    XCTAssertEqual(viewModel.pokemons.count, 1)
    XCTAssertEqual(viewModel.pokemons.first?.name, "Pikachu")
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertNil(viewModel.errorMessage)
  }
  
  func testFetchPokemons_Failure() async {
    // Arrange
    mockUseCase.mockError = NSError(domain: "APIError", code: 0, userInfo: nil)
    
    // Act
    await viewModel.fetchPokemons()
    
    // Assert
    XCTAssertEqual(viewModel.pokemons.count, 0)
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertNotNil(viewModel.errorMessage)
  }
}

// Mock Use Case
class MockFetchPokemonListUseCase: FetchPokemonListUseCaseProtocol {
  var mockResponse: PokemonListResponse?
  var mockError: Error?
  
  func execute() async throws -> PokemonListResponse {
    if let error = mockError {
      throw error
    }
    guard let response = mockResponse else {
      throw NSError(domain: "MockError", code: 0, userInfo: nil)
    }
    return response
  }
}
