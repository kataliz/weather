//
//  DayTemperature.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

struct DayTemperature: Codable {
    var day: Float
    var night: Float
    var evening: Float
    var morning: Float
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case day
        case night
        case evening = "eve"
        case morning = "morn"
    }
}
