//
//  MockCacheStorage.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
@testable import Weather

class MockCacheStorage: ICacheStorage {
    
    // MARK: Properties
    
    private var forecasts = [String: Forecast]()
    
    // MARK: Forecast
    
    func forecast(for city: String) -> Forecast? {
        return forecasts[city]
    }
    
    func set(forecast: Forecast, for city: String) {
        forecasts[city] = forecast
    }
    
    func clear() {
        forecasts = [String: Forecast]()
    }
}
