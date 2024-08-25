//
//  Runtime.swift
//  MoviesCatalog
//
//  Created by avz on 25/08/24.
//

import Foundation

struct Runtime {
    let hours: Int
    let minutes: Int
    
    init(totalMinutes: Int) {
        self.hours = totalMinutes / 60
        self.minutes = totalMinutes % 60
    }
    
    var displayedRuntime: String {
        return "\(hours)h \(minutes)m"
    }
    
    var voiceOverFriendlyRuntime: String {
        let hoursText = (hours == 1) ? "\(hours) hour" : "\(hours) hours"
        let minutesText = (minutes == 1) ? "\(minutes) minute" : "\(minutes) minutes"
        
        return "\(hoursText) and \(minutesText)"
    }
}
