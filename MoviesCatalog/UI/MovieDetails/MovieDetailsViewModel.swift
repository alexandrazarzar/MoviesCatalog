//
//  MovieDetailsViewModel.swift
//  MoviesCatalog
//
//  Created by avz on 24/08/24.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}
