//
//  OnCinemasViewModel.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    @Published var errorDescription: String?
    @Published var movies: [Movie] = []
    
    private let movieService: MovieService
    private let analyticService: AnalyticService

    init(movieService: MovieService = MovieService.shared,
         analyticService: AnalyticService = AnalyticService.shared
    ) {
        self.movieService = movieService
        self.analyticService = analyticService
        loadMovies()
    }
    
    func loadMovies() {
        movieService.fetchNowPlayingMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.movies = response.results.map { Movie(movieResponse: $0) }
            case .failure(let error):
                self.errorDescription = error.description
            }
        }
    }
    
    func onViewAppear() {
        analyticService.registerEvent(page: "In theaters movie list", action: "ViewAppear")
    }
    
    func onMovieCellTapped() {
        analyticService.registerEvent(page: "In theaters movie list", action: "MovieCellTapped")
    }
}

