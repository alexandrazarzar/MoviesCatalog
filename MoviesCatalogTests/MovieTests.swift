//
//  MovieResponseTests.swift
//  MoviesCatalogTests
//
//  Created by avz on 25/08/24.
//
import XCTest
@testable import MoviesCatalog

final class MovieTests: XCTestCase {
    var movie: Movie!
    var movieResponse: MovieResponse!
    
    var movieWithEdgeCaseValues: Movie!
    var movieResponseWithEdgeCaseValues: MovieResponse!
    
    override func setUp() {
        super.setUp()
        
        movieResponse = MovieResponse(
            id: 1,
            title: "Sample Movie",
            overview: "This is a sample movie.",
            voteAverage: 7.5,
            releaseDate: "2023-08-25",
            posterPath: "/samplePosterPath.jpg",
            runtime: 121,
            genres: [MovieGenre(name: "Action"), MovieGenre(name: "Adventure")]
        )
        
        movieResponseWithEdgeCaseValues = MovieResponse(
            id: 1,
            title: "Sample Movie",
            overview: "This is a sample movie.",
            voteAverage: 0,
            releaseDate: "23-03-2001",
            posterPath: "/samplePosterPath.jpg",
            runtime: nil,
            genres: []
        )
        
        movie = Movie(movieResponse: movieResponse)
        movieWithEdgeCaseValues = Movie(movieResponse: movieResponseWithEdgeCaseValues)
    }
    
    func testMovieId_ReturnsCorrectId() {
        XCTAssertEqual(movie.id, movieResponse.id)
    }
    
    func testMovieTitle_ReturnsCorrectTitle() {
        XCTAssertEqual(movie.title, movieResponse.title)
    }
    
    func testMovieOverview_ReturnsCorrectOverview() {
        XCTAssertEqual(movie.overview, movieResponse.overview)
    }
    
    func testMovieVoteAverage_ValidVote_ReturnsFormattedString() {
        XCTAssertEqual(movie.voteAverage, "7.50")
    }
    
    func testMovieVoteAverage_InvalidVote_ReturnsNA() {
        XCTAssertEqual(movieWithEdgeCaseValues.voteAverage, "n/a")
    }
    
    func testMovieReleaseDate_ValidDate_ReturnsDate() {
        XCTAssertNotNil(movie.releaseDate)
        XCTAssertEqual(movie.releaseDate?.formatReleaseDateToDisplay(), "Aug 25, 2023")
    }
    
    func testMovieReleaseDate_InvalidDate_ReturnsNil() {
        XCTAssertNil(movieWithEdgeCaseValues.releaseDate)
    }
    
    func testMoviePosterPath_ReturnsCorrectURL() {
        XCTAssertEqual(movie.posterPath?.absoluteString, "https://image.tmdb.org/t/p/w500/samplePosterPath.jpg")
    }
    
    func testMovieRuntime_ValidRuntime_ReturnsCorrectRuntime() {
        XCTAssertNotNil(movie.runtime)
        XCTAssertEqual(movie.runtime?.displayedRuntime, "2h 1m")
        XCTAssertEqual(movie.runtime?.voiceOverFriendlyRuntime, "2 hours and 1 minute")
    }
    
    func testMovieRuntime_NilRuntime_ReturnsNil() {
        XCTAssertNil(movieWithEdgeCaseValues.runtime)
    }
    
    func testMovieGenres_ValidGenres_ReturnsGenreNames() {
        XCTAssertEqual(movie.genres, ["Action", "Adventure"])
    }
    
    func testMovieGenres_NoGenres_ReturnsEmptyArray() {
        XCTAssertEqual(movieWithEdgeCaseValues.genres, [])
    }
}

