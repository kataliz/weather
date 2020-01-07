//
//  ApiPath.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

enum ForecastApiPath: IApiPath {
    case byDays
    case current
    
    var url: URL {
        guard let result = URL(string: path) else {
            fatalError("Some configurations go wrong")
        }
        
        return result
    }
    
    // MARK: Private
    
    private var path: String {
        switch self {
        case .byDays: return "https://api.openweathermap.org/data/2.5/forecast/daily"
        case .current: return "https://api.openweathermap.org/data/2.5/weather"
        }
    }
}
