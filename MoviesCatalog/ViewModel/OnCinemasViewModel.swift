//
//  OnCinemasViewModel.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import Foundation

class OnCinemasViewModel: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var errorDescription: String = "Could not load movie list"
    
    private let movieService: MovieService

    init(movieService: MovieService = MovieService.shared) {
        self.movieService = movieService
    }
    
    func loadMoviesOnCinema() {
          MovieService.shared.fetchMovies() { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.errorDescription = error.description
            }
        }
    }
    
}
