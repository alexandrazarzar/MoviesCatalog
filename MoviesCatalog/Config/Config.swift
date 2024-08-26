//
//  Config.swift
//  MoviesCatalog
//
//  Created by avz on 25/08/24.
//

import Foundation

class Config {
    static let shared = Config()

    private init() { }

    var baseURL: String {
        return value(for: "baseURL")
    }

    var apiKey: String {
        return value(for: "apiKey")
    }

    private func value(for key: String) -> String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let xml = FileManager.default.contents(atPath: path),
              let config = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String: Any] else {
            fatalError("Missing Config.plist")
        }

        guard let value = config[key] as? String else {
            fatalError("Missing \(key) in Config.plist")
        }
        return value
    }
}
