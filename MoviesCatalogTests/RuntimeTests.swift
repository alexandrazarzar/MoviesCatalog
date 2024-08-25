//
//  RuntimeTests.swift
//  MoviesCatalogTests
//
//  Created by avz on 25/08/24.
//

import XCTest
@testable import MoviesCatalog

final class RuntimeTests: XCTestCase {
    
    func testRuntime_ValidMinutes_ReturnsCorrectHoursAndMinutes() {
        let runtime = Runtime(totalMinutes: 135)
        XCTAssertEqual(runtime.hours, 2)
        XCTAssertEqual(runtime.minutes, 15)
    }
    
    func testDisplayedRuntime_ValidData_ShouldReturnCorrectFormat() {
        let runtime = Runtime(totalMinutes: 90)
        XCTAssertEqual(runtime.displayedRuntime, "1h 30m")
    }
    
    func testVoiceOverFriendlyRuntime_SingleHourAndMinute_ShouldReturnCorrectFormat() {
        let runtime = Runtime(totalMinutes: 61)
        XCTAssertEqual(runtime.voiceOverFriendlyRuntime, "1 hour and 1 minute")
    }
    
    func testVoiceOverFriendlyRuntime_MultipleHoursAndMinutes_ShouldReturnCorrectFormat() {
        let runtime = Runtime(totalMinutes: 125)
        XCTAssertEqual(runtime.voiceOverFriendlyRuntime, "2 hours and 5 minutes")
    }
}
