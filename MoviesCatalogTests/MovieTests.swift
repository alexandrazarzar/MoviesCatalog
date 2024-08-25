//
//  MovieTests.swift
//  MoviesCatalogTests
//
//  Created by avz on 24/08/24.
//

import XCTest
@testable import MoviesCatalog

final class MovieTests: XCTestCase {
    
    var completeMovieResponse: MovieResponse!
    var incompleteMovieResponse: MovieResponse!
    var completeMovie: Movie!
    var incompleteMovie: Movie!

    override func setUp() {
        super.setUp()

        completeMovieResponse = MovieResponse(
            id: 1,
            title: "Sample Movie",
            overview: "This is a sample movie.",
            voteAverage: 7.5,
            releaseDate: "2023-08-24",
            posterPath: "/samplePosterPath.jpg",
            runtime: 120,
            genres: [MovieGenre(name: "Action"), MovieGenre(name: "Adventure")]
        )
        
        incompleteMovieResponse = MovieResponse(
            id: 1,
            title: "Sample Movie",
            overview: "This is a sample movie.",
            voteAverage: 0,
            releaseDate: "",
            posterPath: "/samplePosterPath.jpg",
            runtime: nil,
            genres: nil
        )
        
        completeMovie = Movie(movieResponse: completeMovieResponse)
        incompleteMovie = Movie(movieResponse: incompleteMovieResponse)
    }
    
    func testVoteAverage_ValidVoteAverage_ReturnsCorrectString() {
        XCTAssertEqual(completeMovie.voteAverage, "7.50")
    }

    func testVoteAverage_ZeroVoteAverage_ReturnsNA() {
        XCTAssertEqual(incompleteMovie.voteAverage, "n/a")
    }

    func testReleaseDate_ValidDate_ReturnsCorrectDate() {
        XCTAssertEqual(completeMovie.releaseDate, "Aug 24, 2023")
    }

    func testReleaseDate_InvalidDate_ReturnsNA() {
        XCTAssertEqual(incompleteMovie.releaseDate, "n/a")
    }

    func testPosterPath_ValidPosterPath_ReturnsCorrectFullURL() {
        XCTAssertEqual(completeMovie.posterPath?.absoluteString, "https://image.tmdb.org/t/p/w500/samplePosterPath.jpg")
    }

    func testRuntime_ValidRuntime_ReturnsCorrectRuntime() {
        XCTAssertEqual(completeMovie.runtime, "2h 0m")
    }

    func testRuntime_NilRuntime_ReturnsNA() {
        XCTAssertEqual(incompleteMovie.runtime, "n/a")
    }

    func testGenres_ValidGenres_ReturnsCorrectGereNames() {
        XCTAssertEqual(completeMovie.genres, ["Action", "Adventure"])
    }

    func testGenres_NoGenres_ReturnsEmptyArray() {
        XCTAssertEqual(incompleteMovie.genres, [])
    }
}
