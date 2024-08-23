//
//  Movie.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import Foundation

struct MovieList: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let voteAverage: Double
    let runtime: Int?
    let releaseDate: String?
    let genres: [MovieGenre]?
    
    var formattedVoteAverage: String {
        if voteAverage > 0 {
            return String(format: "%.2f", voteAverage)
        } else {
            return "No data"
        }
    }
    
    var formattedReleaseDate: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterDisplay = DateFormatter()
        dateFormatterDisplay.dateFormat = "MMM dd, yyyy"

        if let releaseDate = releaseDate,
           let date = dateFormatterGet.date(from: releaseDate) {
            return dateFormatterDisplay.string(from: date)
        } else {
           return "No data"
        }
    }
}

struct MovieGenre: Decodable, Hashable {
    let name: String
}
