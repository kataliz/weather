//
//  IUnitFormatter.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

protocol IUnitFormatter {
    func temperature(_ value: Float) -> String
    func pressure(_ value: Float) -> String
    func humidity(_ value: Float) -> String
    func wind(_ value: Float, degrees: Float) -> String
    func volume(_ value: Float) -> String
}

extension IUnitFormatter {
    func dayTemperature(from dayInfo: DayTemperature) -> TemperatureOnDay {
        return TemperatureOnDay(morning: temperature(dayInfo.morning), day: temperature(dayInfo.day), evening: temperature(dayInfo.evening), night: temperature(dayInfo.night))
    }
}
