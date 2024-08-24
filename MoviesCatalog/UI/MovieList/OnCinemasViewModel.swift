//
//  OnCinemasViewModel.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import Foundation

class OnCinemasViewModel: ObservableObject {
    @Published var errorDescription: String?
    @Published var movies: [Movie] = []
    
    private let movieService: MovieService

    init(movieService: MovieService = MovieService.shared) {
        self.movieService = movieService
        loadMoviesResponse()
    }
    
    func loadMoviesResponse() {
          MovieService.shared.fetchNowPlayingMovies() { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                loadMovies(moviesResponse: response.results)
            case .failure(let error):
                self.errorDescription = error.description
            }
        }
    }
    
    func loadMovies(moviesResponse: [MovieResponse]) {
        for movieResponse in moviesResponse {
            let movie = Movie(movieResponse: movieResponse)
            self.movies.append(movie)
        }
    }
}
