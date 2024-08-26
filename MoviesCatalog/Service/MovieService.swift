//
//  MovieService.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchNowPlayingMovies(completion: @escaping (Result<MovieListResponse, ServiceError>) -> Void)
    func fetchMovie(byID movieID: Int, completion: @escaping (Result<MovieResponse, ServiceError>) -> Void)
}

class MovieService: MovieServiceProtocol {
    static let shared = MovieService()
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService(baseURL: Config.shared.baseURL, 
                                                     apiKey: Config.shared.apiKey))
    {
        self.apiService = apiService
    }
        
    func fetchNowPlayingMovies(completion: @escaping (Result<MovieListResponse, ServiceError>) -> Void) {
        apiService.fetchData(from: "/movie/now_playing", completion: completion)
    }
    
    func fetchMovie(byID movieID: Int, completion: @escaping (Result<MovieResponse, ServiceError>) -> Void) {
        apiService.fetchData(from: "/movie/\(movieID)", completion: completion)
    }
}
