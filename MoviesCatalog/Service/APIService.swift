//
//  APIService.swift
//  MoviesCatalog
//
//  Created by avz on 24/08/24.
//

import Foundation

protocol APIServiceProtocol {
    var baseURL: String { get }
    var apiKey: String { get }
    var jsonDecoder: JSONDecoder { get }
    var session: URLSession { get }

    func fetchData<T: Decodable>(from endpoint: String, completion: @escaping (Result<T, ServiceError>) -> Void)
}

class APIService: APIServiceProtocol {
    let baseURL: String
    let apiKey: String
    let jsonDecoder: JSONDecoder
    let session: URLSession
    
    init(baseURL: String,
         apiKey: String,
         session: URLSession = .shared,
         jsonDecoder: JSONDecoder = JSONDecoder())
    {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.session = session
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchData<T: Decodable>(from endpoint: String, completion: @escaping (Result<T, ServiceError>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint)?api_key=\(apiKey)") else {
            completion(.failure(.endpointNotFound))
            return
        }
        
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                self.handleFailure(.apiFailure(error.localizedDescription), completion: completion)
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
                self.handleFailure(.decodingFailure(error.localizedDescription), completion: completion)
            }
        }.resume()
    }
    
    private func handleFailure<T: Decodable>(_ error: ServiceError, completion: @escaping (Result<T, ServiceError>) -> Void) {
        DispatchQueue.main.async {
            completion(.failure(error))
        }
    }
    
    private func handleSuccess<T: Decodable>(_ response: T, completion: @escaping (Result<T, ServiceError>) -> Void) {
        DispatchQueue.main.async {
            completion(.success(response))
        }
    }
}
