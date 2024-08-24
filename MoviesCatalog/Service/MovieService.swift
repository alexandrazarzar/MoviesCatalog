//
//  MovieService.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import Foundation

protocol GenericAPIService {
    var baseURL: String { get }
    var apiKey: String { get }
    var jsonDecoder: JSONDecoder { get set }
    
    func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, MovieService.ServiceError>) -> Void)
}

class MovieService: GenericAPIService {
    
    static let shared = MovieService() // Singleton instance
    
    var apiKey = "5a0326c8179306f84e506c8d3ef1522e"
    var baseURL = "https://api.themoviedb.org/3"
    
    var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, ServiceError>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint)?api_key=\(apiKey)") else {
            completion(.failure(.endpointNotFound))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let _ = error {
                self.handleFailure(.apiFailure, completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.handleFailure(.invalidResponse, completion: completion)
                return
            }
            
            guard let data = data else {
                self.handleFailure(.invalidResponse, completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(T.self, from: data)
                self.handleSuccess(decodedResponse, completion: completion)
            } catch {
                self.handleFailure(.decodingFailure, completion: completion)
            }
        }.resume()
    }
    
    func fetchNowPlayingMovies(completion: @escaping (Result<MovieListResponse, ServiceError>) -> Void) {
        fetchData(endpoint: "/movie/now_playing", completion: completion)
    }
    
    func fetchMovie(byID movieID: Int, completion: @escaping (Result<MovieResponse, ServiceError>) -> Void) {
        fetchData(endpoint: "/movie/\(movieID)", completion: completion)
    }
    
    private func handleFailure<D: Decodable>(_ error: ServiceError, completion: @escaping (Result<D, ServiceError>) -> Void) {
        DispatchQueue.main.async {
            completion(.failure(error))
        }
    }
    
    private func handleSuccess<D: Decodable>(_ response: D, completion: @escaping (Result<D, ServiceError>) -> Void) {
        DispatchQueue.main.async {
            completion(.success(response))
        }
    }
    
    enum ServiceError: Error {
        case endpointNotFound
        case apiFailure
        case invalidResponse
        case decodingFailure
        
        var description: String {
            switch self {
            case .endpointNotFound:
                return "Endpoint not found"
            case .apiFailure:
                return "API presented error"
            case .invalidResponse:
                return "Response is invalid"
            case .decodingFailure:
                return "Failure in decoding"
            }
        }
    }
}
