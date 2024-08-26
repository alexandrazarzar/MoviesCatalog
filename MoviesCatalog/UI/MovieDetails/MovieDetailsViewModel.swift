//
//  MovieDetailsViewModel.swift
//  MoviesCatalog
//
//  Created by avz on 24/08/24.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var errorMessage: String?
    
    private let movieService: MovieService
    private let analyticService: AnalyticService
    
    var voiceOverFriendlyRuntime: String {
        if let movie = movie, let runtime = movie.runtime {
            return runtime.voiceOverFriendlyRuntime
        }
        return "No runtime information available"
    }
    
    var displayRuntime: String {
        if let movie = movie, let runtime = movie.runtime {
            return runtime.displayedRuntime
        }
        return "n/a"
    }
    
    var releaseDate: String {
        if let movie = movie, let releaseDate = movie.releaseDate {
            return "Released in \(releaseDate.formatReleaseDateToVoiceOver())"
        }
        return "No release date information"
    }
    
    init(movieService: MovieService = MovieService.shared,
         analyticService: AnalyticService = AnalyticService.shared,
         movieID: Int
    ){
        self.movieService = movieService
        self.analyticService = analyticService
        getMovie(byID: movieID)
    }
    
    func getMovie(byID movieID: Int) {
        MovieService.shared.fetchMovie(byID: movieID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self?.movie = Movie(movieResponse: movie)
                case .failure(let error):
                    self?.errorMessage = error.description
                }
            }
        }
    }
    
    func onMovieDetailsAppear() {
        let movieTitle = movie?.title ?? "Movie"
        analyticService.registerEvent(page: "\(movieTitle) details view", action: "ViewAppear")
    }
}
