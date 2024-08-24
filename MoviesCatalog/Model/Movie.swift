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
    
    var releaseDate: String {
        return formatReleaseDate(movieResponse.releaseDate)
    }
    
    var posterPath: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(movieResponse.posterPath)")
    }
    var runtime: String {
        return formatRuntime(movieResponse.runtime)
    }
    
    var genres: [String] {
        return getGenresNames(movieResponse.genres)
    }
    
    required init(movieResponse: MovieResponse) { // Adapter Pattern
        self.movieResponse = movieResponse
    }
    
    static private var dateFormatterGet: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    static private var dateFormatterDisplay: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter
    }
    
    private func formatReleaseDate(_ date: String) -> String {
        if let dateStr = Movie.dateFormatterGet.date(from: date) {
            return Movie.dateFormatterDisplay.string(from: dateStr)
        } else {
            return "n/a"
        }
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
    
    private func formatRuntime(_ runtime: Int?) -> String {
        guard let runtime else { return "n/a" }
        
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
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
