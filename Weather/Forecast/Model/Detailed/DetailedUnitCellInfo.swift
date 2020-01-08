//
//  DetailedUnitCellInfo.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

struct DetailedUnitCellInfo: DayDetailedCellInfo {
    let cell: DayDetailedCell.Type = DetailedUnitCell.self
    let icon: UIImage
    let name: String
    let info: String
}
