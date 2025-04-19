//
//  MockAPIClient.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 19/04/25.
//
import Testing
@testable import PokeDexApp
import Foundation

class MockAPIClient: APIClientProtocol {
    var mockResponse: Data?  // Agora esperamos Data, não PokemonListResponse
    var mockError: Error?
    
    func request<T: Decodable>(_ endpoint: Request) async throws -> T {
        // Se houver um erro simulado, lance-o
        if let error = mockError {
            throw error
        }
        
        // Se a resposta simulada não for nil, decodifique-a para o tipo esperado
        if let data = mockResponse {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw APIError.decodingError(error)
            }
        }
        
        // Se não houver dados, lance um erro padrão
        throw APIError.invalidResponse
    }
}
