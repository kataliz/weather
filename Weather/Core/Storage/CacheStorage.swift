//
//  CacheStorage.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

class CacheStorage: ICacheStorage {
   
    // MARK: Properties
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private var defaults = UserDefaults.standard
    
    // MARK: ICacheStorage
    
    func forecast(for city: String) -> Forecast? {
        return load(key: city)
    }
    
    func set(forecast: Forecast, for city: String) {
        save(item: forecast, key: city)
    }
    
    // MARK: Helpers
    
    private func save<T>(item: T?, key: String) where T: Codable {
        guard let item = item else {
            defaults.set(nil, forKey: key)
            return
        }
        
        guard let data = try? encoder.encode(item) else {
            return
        }
        
        defaults.set(data, forKey: key)
    }
    
    private func load<T>(key: String) -> T? where T: Codable {
        guard let data = defaults.value(forKey: key) as? Data,
            let info = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        
        return info
    }
}
