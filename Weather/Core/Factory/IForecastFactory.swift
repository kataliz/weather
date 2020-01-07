//
//  IForecastFactory.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

protocol IForecastFactory {
    var forecastProvider: IForecastProvider { get }
    var forecastAdapter: IForecastAdapter { get }
    var detailedAdapter: IDayDetailedAdapter { get }
    var storage: ICacheStorage { get }
}
