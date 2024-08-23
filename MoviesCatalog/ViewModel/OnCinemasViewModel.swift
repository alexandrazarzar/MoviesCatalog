//
//  OnCinemasViewModel.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import Foundation

class OnCinemasViewModel: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var error: NSError?
    
    
    func loadMoviesOnCinema() {
          MovieService.shared.fetchMovies() { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
}
