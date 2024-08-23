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
        return String(format: "%.2f", voteAverage)
    }
}

struct MovieGenre: Decodable, Hashable {
    let name: String
}
