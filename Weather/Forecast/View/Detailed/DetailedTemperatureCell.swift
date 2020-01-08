//
//  DetailedTemperatureCell.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class DetailedTemperatureCell: DayDetailedCell {
    
    // MARK: Outlets
    
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var name: UILabel!
    @IBOutlet private var relative: UILabel!
    @IBOutlet private var morningValue: UILabel!
    @IBOutlet private var dayValue: UILabel!
    @IBOutlet private var eveningValue: UILabel!
    @IBOutlet private var nightValue: UILabel!
    @IBOutlet private var morningFeels: UILabel!
    @IBOutlet private var dayFeels: UILabel!
    @IBOutlet private var eveningFeels: UILabel!
    @IBOutlet private var nightFeels: UILabel!
    
    // MARK: Configure
    
    override func configure(viewModel: DayDetailedCellInfo) {
        guard let viewModel = viewModel as? DetailedTemperatureCellInfo else {
            return
        }
        
        icon.image = viewModel.icon
        name.text = viewModel.name
        
        relative.text = viewModel.relative == .hot ? "Hot" : viewModel.relative == .cold ? "Cold" : ""
        relative.textColor = viewModel.relative == .hot ? UIColor.hotColor : UIColor.coldColor
        
        morningValue.text = viewModel.value.morning
        morningFeels.text = viewModel.feels.morning
        
        dayValue.text = viewModel.value.day
        dayFeels.text = viewModel.feels.day
        
        eveningValue.text = viewModel.value.evening
        eveningFeels.text = viewModel.feels.evening
        
        nightValue.text = viewModel.value.night
        nightFeels.text = viewModel.feels.night
    }
}
