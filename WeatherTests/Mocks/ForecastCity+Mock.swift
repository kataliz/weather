//
//  ForecastCity+Mock.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
@testable import Weather

extension ForecastCity {
    static func mockParis() -> ForecastCity {
        return ForecastCity(id: 2988507, name: "Paris", timezone: 3600)
    }
}
