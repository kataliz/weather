//
//  ICacheStorage.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

protocol ICacheStorage {
    func forecast(for city: String) -> Forecast?
    func set(forecast: Forecast, for city: String)
}
