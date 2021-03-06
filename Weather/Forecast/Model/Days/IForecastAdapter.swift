//
//  IForecastAdapter.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

protocol IForecastAdapter: class {
    func transformDaysWeather(from forecast: Forecast) -> ForecastInfo
}
