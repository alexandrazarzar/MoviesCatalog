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
    
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "5a0326c8179306f84e506c8d3ef1522e"
    
    private let apiService: APIService = APIService(baseURL: baseURL, apiKey: apiKey)
    
    func fetchNowPlayingMovies(completion: @escaping (Result<MovieListResponse, ServiceError>) -> Void) {
        apiService.fetchData(from: "/movie/now_playing", completion: completion)
    }
    
    func fetchMovie(byID movieID: Int, completion: @escaping (Result<MovieResponse, ServiceError>) -> Void) {
        apiService.fetchData(from: "/movie/\(movieID)", completion: completion)
    }
}
