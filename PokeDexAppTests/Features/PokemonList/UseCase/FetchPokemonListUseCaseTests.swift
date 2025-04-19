//
//  FetchPokemonListUseCaseTests.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 19/04/25.
//

import XCTest
@testable import PokeDexApp

class FetchPokemonListUseCaseTests: XCTestCase {
  
  var mockRepository: MockPokemonRepository!
  var useCase: FetchPokemonListUseCase!
  
  override func setUp() {
    super.setUp()
    mockRepository = MockPokemonRepository()
    useCase = FetchPokemonListUseCase(repository: mockRepository)
  }
  
  override func tearDown() {
    mockRepository = nil
    useCase = nil
    super.tearDown()
  }
  
  func testExecute_Success() async throws {
    // Arrange
    let expectedResponse = PokemonListResponse(count: 1, next: nil, previous: nil, results: [PokemonEntity(name: "Pikachu", url: "")])
    mockRepository.mockResponse = expectedResponse
    
    // Act
    let response = try await useCase.execute()
    
    // Assert
    XCTAssertEqual(response.results.count, 1)
    XCTAssertEqual(response.results.first?.name, "Pikachu")
  }
  
  func testExecute_Failure() async throws {
    // Arrange
    mockRepository.mockError = NSError(domain: "APIError", code: 0, userInfo: nil)
    
    // Act & Assert
    do {
      _ = try await useCase.execute()
      XCTFail("Expected error but got success")
    } catch {
      XCTAssertNotNil(error)
    }
  }
}

// Mock Repository
class MockPokemonRepository: PokemonRepository {
  var mockResponse: PokemonListResponse?
  var mockError: Error?
  
  func fetchPokemonList() async throws -> PokemonListResponse {
    if let error = mockError {
      throw error
    }
    guard let response = mockResponse else {
      throw NSError(domain: "MockError", code: 0, userInfo: nil)
    }
    return response
  }
}
