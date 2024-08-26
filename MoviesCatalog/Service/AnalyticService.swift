//
//  AnalyticService.swift
//  MoviesCatalog
//
//  Created by avz on 25/08/24.
//

import Foundation

class AnalyticService {
    
    static let shared = AnalyticService()

    func registerEvent(page: String, action: String) {
        print("Analytics Event - Page: \(page), Action: \(action)")
    }
}

