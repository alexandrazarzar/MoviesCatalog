//
//  DateFormattingTests.swift
//  MoviesCatalogTests
//
//  Created by avz on 25/08/24.
//

import XCTest
@testable import MoviesCatalog

final class DateFormattingTests: XCTestCase {
    
    func testDateFormatterGet_ValidDate_ReturnsCorrectDate() {
          let date = DateFormatting.dateFormatterGet.date(from: "2023-08-25")
          XCTAssertNotNil(date)
      }
    
    func testDateFormatterDisplay_ValidDate_ShouldBeSuccessful() {
        let date = DateFormatting.dateFormatterGet.date(from: "1970-01-01")
        if let date = date {
            let formattedDate = date.formatReleaseDateToDisplay()
            XCTAssertEqual(formattedDate, "Jan 01, 1970")
        } else {
            XCTFail()
        }
    }
    
    func testDateFormatterDisplay_InvalidDate_ShouldReturnNil() {
        let date = DateFormatting.dateFormatterGet.date(from: "1970-019-01")
       XCTAssertNil(date)
    }
    
    func testDateFormatterAccessibility_CorrectFormat() {
        let date = DateFormatting.dateFormatterGet.date(from: "1970-01-01")
        if let date = date {
            let formattedDate = date.formatReleaseDateToVoiceOver()
            XCTAssertEqual(formattedDate, "January 1, 1970")
        } else {
            XCTFail()
        }
    }
}

