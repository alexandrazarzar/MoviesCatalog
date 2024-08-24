//
//  MovieTests.swift
//  MoviesCatalogTests
//
//  Created by avz on 24/08/24.
//

import XCTest
@testable import MoviesCatalog

final class MovieTests: XCTestCase {
    
    var completeMovieResponse = MovieResponse(
        id: 1,
        title: "Sample Movie",
        overview: "This is a sample movie.",
        voteAverage: 7.5,
        releaseDate: "2023-08-24",
        posterPath: "/samplePosterPath.jpg",
        runtime: 120,
        genres: [MovieGenre(name: "Action"), MovieGenre(name: "Adventure")]
    )
    
    var incompleteMovieResponse = MovieResponse(
        id: 1,
        title: "Sample Movie",
        overview: "This is a sample movie.",
        voteAverage: 0,
        releaseDate: "",
        posterPath: "/samplePosterPath.jpg",
        runtime: nil,
        genres: nil
    )
    
    var completeMovie: Movie!
    var incompleteMovie: Movie!
    
    override func setUp() {
        super.setUp()

        completeMovie = Movie(movieResponse: completeMovieResponse)
        incompleteMovie = Movie(movieResponse: incompleteMovieResponse)

    }
    
//    override func tearDown() {
//        movieResponse = nil
//        movie = nil
//        super.tearDown()
//    }
    
    func testMovieVoteAverage() {
        XCTAssertEqual(completeMovie.voteAverage, "7.50")
        XCTAssertEqual(incompleteMovie.voteAverage, "n/a")
    }
    
    func testMovieReleaseDate() {
        XCTAssertEqual(completeMovie.releaseDate, "Aug 24, 2023")
        XCTAssertEqual(incompleteMovie.releaseDate, "n/a")
    }
    
    func testMoviePosterPath() {
        XCTAssertEqual(completeMovie.posterPath?.absoluteString, "https://image.tmdb.org/t/p/w500/samplePosterPath.jpg")
    }
    
    func testMovieRuntime() {
        XCTAssertEqual(completeMovie.runtime, "2h 0m")
        XCTAssertEqual(incompleteMovie.runtime, "n/a")
    }
    
    func testMovieGenres() {
        XCTAssertEqual(completeMovie.genres, ["Action", "Adventure"])
        XCTAssertEqual(incompleteMovie.genres, [])
    }
}
