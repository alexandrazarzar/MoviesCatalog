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
    private let apiService: APIService
    
    init(apiService: APIService = APIService(baseURL: "https://api.themoviedb.org/3", apiKey: "5a0326c8179306f84e506c8d3ef1522e")) {
        self.apiService = apiService
    }
    
    func fetchNowPlayingMovies(completion: @escaping (Result<MovieListResponse, ServiceError>) -> Void) {
        apiService.fetchData(from: "/movie/now_playing", completion: completion)
    }
    
    func fetchMovie(byID movieID: Int, completion: @escaping (Result<MovieResponse, ServiceError>) -> Void) {
        apiService.fetchData(from: "/movie/\(movieID)", completion: completion)
    }
}
