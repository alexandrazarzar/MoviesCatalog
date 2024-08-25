//
//  MoviesCatalogUITests.swift
//  MoviesCatalogUITests
//
//  Created by avz on 22/08/24.
//

import XCTest

final class MoviesListViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testMoviesListView_ShowsMoviesList() throws {
        let inTheatersText = app.staticTexts["In Theaters"]
        XCTAssertTrue(inTheatersText.exists, "The header should be visible")
        
        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.waitForExistence(timeout: 5), "Scroll View of movies should exist")
    }
    
    func testMoviesListView_ShowsAMovieCell() throws {
        let firstNavigationLink = app.otherElements.firstMatch
        
        XCTAssertTrue(firstNavigationLink.waitForExistence(timeout: 5), "The first NavigationLink should appear in the app")
        XCTAssertTrue(firstNavigationLink.exists, "First NavigationLink should exist in the app")
        XCTAssertTrue(firstNavigationLink.isHittable, "First NavigationLink should be tappable")
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
