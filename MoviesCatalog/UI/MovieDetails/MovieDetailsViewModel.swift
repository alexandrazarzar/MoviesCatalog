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
    
    var movieTitle: String {
        movie?.title ?? "Unknown Title"
    }
    
    var releaseDate: String {
        if let releaseDate = movie?.releaseDate {
            return "Released in \(releaseDate.formatReleaseDateToVoiceOver())"
        }
        return "No release date information"
    }
    
    var posterURL: URL? {
        movie?.posterPath
    }
    
    var voteAverage: String {
        movie?.voteAverage ?? "n/a"
    }
    
    var displayRuntime: String {
        if let runtime = movie?.runtime {
            return runtime.displayedRuntime
        }
        return "n/a"
    }
    
    var voiceOverFriendlyRuntime: String {
        if let runtime = movie?.runtime {
            return runtime.voiceOverFriendlyRuntime
        }
        return "No runtime information available"
    }
    
    var genresText: String {
        if let genres = movie?.genres {
            return genres.joined(separator: " • ")
        }
        return "No genre information available"
    }
    
    var overview: String {
        movie?.overview ?? "No overview available"
    }
    
    init(movieService: MovieService = MovieService.shared,
         analyticService: AnalyticService = AnalyticService.shared,
         movieID: Int
    ) {
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

