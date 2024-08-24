//
//  ServiceError.swift
//  MoviesCatalog
//
//  Created by avz on 24/08/24.
//

import Foundation

enum ServiceError: Error {
    case endpointNotFound
    case apiFailure(String)
    case invalidResponse
    case decodingFailure(String)
    
    var description: String {
        switch self {
        case .endpointNotFound:
            return "Endpoint not found"
        case .apiFailure(let message):
            return "API error: \(message)"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingFailure(let message):
            return "Decoding error: \(message)"
        }
    }
}
