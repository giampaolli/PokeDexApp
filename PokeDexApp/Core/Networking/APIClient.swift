//
//  APIClient.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import Foundation

protocol APIClientProtocol {
  func request<T: Decodable>(_ endpoint: Request) async throws -> T
}

final class APIClient: APIClientProtocol {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func request<T: Decodable>(_ endpoint: Request) async throws -> T {
    let request = try makeRequest(for: endpoint)
    
    logRequest(request)
    
    let (data, response) = try await session.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      print("❌ Invalid response")
      throw APIError.invalidResponse
    }
    
    print("📡 Response Status Code: \(httpResponse.statusCode)")
    
    if let jsonString = String(data: data, encoding: .utf8) {
      print("📦 Response Body: \(jsonString)")
    }
    
    guard 200..<300 ~= httpResponse.statusCode else {
      print("❌ HTTP Error: \(httpResponse.statusCode)")
      throw APIError.httpError(statusCode: httpResponse.statusCode)
    }
    
    do {
      let decodedData = try JSONDecoder().decode(T.self, from: data)
      return decodedData
    } catch {
      print("❌ Decode failed: \(error)")
      if let decodingError = error as? DecodingError {
        switch decodingError {
        case .keyNotFound(let key, let context):
          print("🔑 Key '\(key)' not found:", context.debugDescription)
        case .typeMismatch(_, let context):
          print("❌ Type mismatch:", context.debugDescription)
        case .valueNotFound(_, let context):
          print("❌ Value missing:", context.debugDescription)
        case .dataCorrupted(let context):
          print("💥 Data corrupted:", context.debugDescription)
        @unknown default:
          print("Unknown decoding error")
        }
      }
      throw APIError.decodingError(error)
    }
  }
  
  private func makeRequest(for endpoint: Request) throws -> URLRequest {
    guard let url = endpoint.url else {
      print("❌ Invalid URL")
      throw APIError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    request.allHTTPHeaderFields = endpoint.headers
    
    if let body = endpoint.body {
      request.httpBody = body
    }
    
    return request
  }
  
  private func logRequest(_ request: URLRequest) {
    print("🌐 Request URL: \(request.url?.absoluteString ?? "nil")")
    print("🔁 Method: \(request.httpMethod ?? "nil")")
    print("🧾 Headers: \(request.allHTTPHeaderFields ?? [:])")
    
    if let body = request.httpBody,
       let bodyString = String(data: body, encoding: .utf8) {
      print("📤 Body: \(bodyString)")
    }
  }
}

