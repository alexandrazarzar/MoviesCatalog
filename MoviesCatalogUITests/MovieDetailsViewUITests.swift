//
//  MovieDetailsViewUITests.swift
//  MoviesCatalogUITests
//
//  Created by avz on 25/08/24.
//

import XCTest

final class MovieDetailsViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        let firstMovieCell = app.otherElements.firstMatch
        firstMovieCell.tap()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testMovieDetailsView_ShowsMovieTitle() throws {
        let specificText = app.staticTexts["MovieTitle"]
        XCTAssertTrue(specificText.waitForExistence(timeout: 5), "Movie title should exist in the view.")
    }
    
    func testMovieDetailsView_NavigatesBackToInTheatersView() throws {
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        XCTAssertTrue(backButton.exists, "The back button should be visible")
        
        backButton.tap()
        
        let inTheatersText = app.staticTexts["In Theaters"]
        XCTAssertTrue(inTheatersText.exists, "The header should be visible")
    }
}
