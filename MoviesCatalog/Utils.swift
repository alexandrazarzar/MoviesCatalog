//
//  Utils.swift
//  MoviesCatalog
//
//  Created by avz on 25/08/24.
//

import Foundation

class Utils {
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
    
     static func formatReleaseDateToDisplay(_ date: String) -> String {
         if let dateStr = Utils.dateFormatterGet.date(from: date) {
            return Utils.dateFormatterDisplay.string(from: dateStr)
        } else {
            return "n/a"
        }
    }
    
    static func formatReleaseDateToVoiceOver(_ date: String) -> String {
        if let dateStr = Utils.dateFormatterDisplay.date(from: date) {
           return "Released in \(Utils.dateFormatterAccessibility.string(from: dateStr))"
       } else {
           return "Release date not available"
       }
   }
}
