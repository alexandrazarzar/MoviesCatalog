//
//  MovieListCellViewModel.swift
//  MoviesCatalog
//
//  Created by Alexandra Viana on 23/08/24.
//

import Foundation

class MovieListCellViewModel: ObservableObject { // TODO: sera que precisa mesmo desse view model??
    @Published var movie: Movie
    let title: String
    let voteAverage: String
    let posterURL: URL?
    
    var displayedReleaseDate: String {
        if let releaseDate = movie.releaseDate {
            return releaseDate.formatReleaseDateToDisplay()
        }
        return "N/A"
    }
    
    var voiceOverFriendlyReleaseDate: String {
        if let releaseDate = movie.releaseDate {
            return "Released in \(releaseDate.formatReleaseDateToVoiceOver())"
        }
        return "No release date information"
    }
    
    init(movie: Movie) {
        self.movie = movie
        self.title = movie.title
        self.voteAverage = movie.voteAverage
        self.posterURL = movie.posterPath
    }
}
