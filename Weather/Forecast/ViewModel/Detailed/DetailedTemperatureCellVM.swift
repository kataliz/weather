//
//  DetailedTemperatureCellVM.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

struct DetailedTemperatureCellVM: DayDetailedCellVM {
    let cell: DayDetailedCell.Type = DetailedTemperatureCell.self
    let name: String
    let icon: UIImage
    let relative: TemperatureRelative
    let value: TemperatureOnDay
    let feels: TemperatureOnDay
}
