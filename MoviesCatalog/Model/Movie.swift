//
//  Movie.swift
//  MoviesCatalog
//
//  Created by avz on 24/08/24.
//

import Foundation

class Movie {
    private let movieResponse: MovieResponse
    
    var id: Int { movieResponse.id }
    var title: String { movieResponse.title }
    var overview: String { movieResponse.overview }
    
    var voteAverage: String {
        return formatVoteAverage(movieResponse.voteAverage)
    }
    
    var releaseDate: Date? {
        return DateFormatting.dateFormatterGet.date(from:  movieResponse.releaseDate)
    }
    
    var posterPath: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(movieResponse.posterPath)")
    }
    
    var runtime: Runtime? {
        if let totalMinutes = movieResponse.runtime {
           return Runtime(totalMinutes: totalMinutes)
        }
        return nil
    }
    
    var genres: [String] {
        return getGenresNames(movieResponse.genres)
    }
    
    required init(movieResponse: MovieResponse) { // Adapter Pattern
        self.movieResponse = movieResponse
    }
    
    private func formatVoteAverage(_ voteAverage: Double) -> String {
        if voteAverage > 0 {
            return String(format: "%.2f", voteAverage)
        } else {
            return "n/a"
        }
    }
    
    private func getPosterImageEndpoint(posterPath: String) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
    
    private func getGenresNames(_ genres: [MovieGenre]?) -> [String] {
        var genresList: [String] = []
        
        if let genres {
            for genre in genres {
                genresList.append(genre.name)
            }
        }
        
        return genresList
    }
}

extension Movie: Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
