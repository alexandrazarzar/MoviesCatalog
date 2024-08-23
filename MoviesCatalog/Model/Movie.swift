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
    let id: Int
    let title: String
}
