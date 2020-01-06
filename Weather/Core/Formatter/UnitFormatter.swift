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
        return String(format: "%.0f°", value)
    }
}
