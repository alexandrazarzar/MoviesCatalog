//
//  Utils.swift
//  MoviesCatalog
//
//  Created by avz on 25/08/24.
//

import Foundation

class DateFormatting {
    static var dateFormatterGet: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    static var dateFormatterDisplay: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter
    }
    
    static var dateFormatterAccessibility: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter
    }
}

extension Date {
    func formatReleaseDateToDisplay() -> String {
        return DateFormatting.dateFormatterDisplay.string(from: self)
    }
    
    func formatReleaseDateToVoiceOver() -> String {
        return DateFormatting.dateFormatterAccessibility.string(from: self)
    }
}

