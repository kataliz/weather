//
//  IDayLocalFormatter.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

protocol IDayLocalFormatter {
    func configure(timezone: GMTTimeZone)
    func relativeDay(from date: Date) -> String
    func formattedDay(from date: Date) -> String
    func formattedTime(from date: Date) -> String
}
