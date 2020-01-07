//
//  IDayDetailedAdapter.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

protocol IDayDetailedAdapter {
    func transform(dayInfo: DayWeather, for city: ForecastCity) -> [DayDetailedCellVM]
    func dayName(dayInfo: DayWeather, for city: ForecastCity) -> String
}
