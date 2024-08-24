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
    
    init(movieID: Int) {
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
}
