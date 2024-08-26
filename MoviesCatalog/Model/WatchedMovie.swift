//
//  WatchedMovie.swift
//  MoviesCatalog
//
//  Created by avz on 26/08/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class WatchedMovie {
    var title: String
    var watchedDate: Date
    
    init(movieID: String, watchedDate: Date = Date()) {
        self.title = movieID
        self.watchedDate = watchedDate
    }
}
