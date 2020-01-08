//
//  TemperatureRelative.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

enum TemperatureRelative: String, Equatable {
    case cold
    case hot
    case normal
    
    init(temperature: Float) {
        switch temperature {
        case 25.0...: self = .hot
        case ...10.0: self = .cold
        default: self = .normal
        }
    }
}
