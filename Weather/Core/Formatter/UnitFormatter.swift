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
    func temperature(_ value: Float) -> String {
        let rounded = Int(roundf(value))
        let prefix = rounded > 0 ? "+" : rounded < 0 ? "-" : ""
        return "\(prefix)\(rounded)°"
    }
}
