//
//  WeatherCondition.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

struct WeatherCondition: Codable {
    var type: WeatherType
    var description: String
    var iconName: String
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case type = "main"
        case description
        case iconName = "icon"
    }
    
    // MARK: Computed
    
    var icon: UIImage {
        return UIImage(named: iconName) ?? UIImage()
    }
}

enum WeatherType: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case thunderstorm = "Thunderstorm"
    case rain = "Rain"
    case drizzle = "Drizzle"
    case snow = "Snow"
    case smoke = "Smoke"
    case haze = "Haze"
    case dust = "Dust"
    case fog = "Fog"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"
    case mist = "Mist"
    case unknown
}
