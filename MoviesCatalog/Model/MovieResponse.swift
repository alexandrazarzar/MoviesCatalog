//
//  Movie.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import Foundation

struct MovieListResponse: Decodable {
    let results: [MovieResponse]
}

struct MovieResponse: Decodable, Hashable {
    static func == (lhs: MovieResponse, rhs: MovieResponse) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let posterPath: String
    let runtime: Int?
    let genres: [MovieGenre]?
}

    



struct MovieGenre: Decodable, Hashable {
    let name: String
}
