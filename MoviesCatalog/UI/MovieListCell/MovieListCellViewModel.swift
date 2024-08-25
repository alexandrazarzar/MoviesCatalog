//
//  MovieListCellViewModel.swift
//  MoviesCatalog
//
//  Created by Alexandra Viana on 23/08/24.
//

import Foundation

class MovieListCellViewModel: ObservableObject { // sera que precisa mesmo desse view model??
    @Published var movie: Movie
    
    let title: String
    let voteAverage: String
    let releaseDate: String
    let voiceOverReleaseDate: String
    let posterURL: URL?
        

    init(movie: Movie) {
        self.movie = movie
        self.title = movie.title
        self.voteAverage = movie.voteAverage
        self.releaseDate = movie.releaseDate
        self.posterURL = movie.posterPath
        self.voiceOverReleaseDate = movie.voiceOverFriendlyReleaseDate
    }
}
