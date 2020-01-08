//
//  DayWeatherCell.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class DayWeatherCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet private var date: UILabel!
    @IBOutlet private var dateRelative: UILabel!
    @IBOutlet private var weatherIcon: UIImageView!
    @IBOutlet private var dayTemperature: UILabel!
    @IBOutlet private var nightTemperature: UILabel!
    
    // MARK: Configure
    
    public func configure(viewModel: DayWeatherInfo) {
        date.text = viewModel.date
        dateRelative.text = viewModel.dateRelative
        weatherIcon.image = viewModel.weatherIcon
        dayTemperature.text = viewModel.dayTemperature
        nightTemperature.text = viewModel.nightTemperature
    }
}
