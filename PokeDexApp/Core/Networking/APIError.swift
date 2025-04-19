//
//  APIError.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import Foundation

enum APIError: Error, LocalizedError {
  case invalidURL
  case invalidResponse
  case httpError(statusCode: Int)
  case decodingError(Error)
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "URL inválida."
    case .invalidResponse:
      return "Resposta inválida do servidor."
    case .httpError(let code):
      return "Erro HTTP com código: \(code)"
    case .decodingError(let error):
      return "Erro ao decodificar os dados: \(error.localizedDescription)"
    }
  }
}
