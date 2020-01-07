//
//  UnitFormatter.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

/// Formatting units in Metric system
class UnitFormatter: IUnitFormatter {
    
    // MARK: IUnitFormatter
    
    /**
    Formatting temperature value in Celsius with using symbols

    - Parameter value: Temperature value in Celsius
    */
    func temperature(_ value: Float) -> String {
        let rounded = Int(roundf(value))
        let prefix = rounded > 0 ? "+" : rounded < 0 ? "-" : ""
        return "\(prefix)\(rounded)°"
    }
    
    /**
    Formatting volume in mm

    - Parameter value: Volume in mm
    */
    func volume(_ value: Float) -> String {
        return "\(Int(roundf(value))) mm"
    }
    
    /**
    Formatting pressue value in hPa to mmHg

    - Parameter value: Pressure value in hPa
    */
    func pressure(_ value: Float) -> String {
        return "\(Int(roundf(value/1.3332239))) mmHg"
    }
    
    func humidity(_ value: Float) -> String {
        return "\(Int(roundf(value))) %"
    }
    
    /**
    Formatting wind speed and degrees.

    - Parameters:
        - value: Wind speed in m/s
        - degrees: Wind degrees between 0.0 and 360.0
    */
    func wind(_ value: Float, degrees: Float) -> String {
        return "\(Int(roundf(value))) m/s, \(direction(from: degrees))"
    }
    
    private func direction(from degrees: Float) -> String {
        let corrected = min(360.0,max(0.0,degrees))
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        return directions[Int((corrected + 22.5)/45.0) % 8]
    }
}
