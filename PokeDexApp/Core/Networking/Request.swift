//
//  Request.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import Foundation

class Request {
  let path: String
  let method: HTTPMethod
  let headers: [String: String]
  let body: Data?
  
  let baseUrl: String = "https://pokeapi.co/api/v2/"
  
  init(path: String, method: HTTPMethod = .get, headers: [String : String] = [:], body: Data? = nil) {
    self.path = path
    self.method = method
    self.headers = headers
    self.body = body
  }
  
  var url: URL? {
    URL(string: "\(baseUrl)\(path)")
  }
  
  static var pokemonList = Request(path: "pokemon?limit=151")
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
