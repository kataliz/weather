//
//  DetailedUnitCell.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class DetailedUnitCell: DayDetailedCell {
    
    // MARK: Outlets
    
    @IBOutlet private var name: UILabel!
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var info: UILabel!
    
    // MARK: Configure
    
    override func configure(viewModel: DayDetailedCellVM) {
        guard let viewModel = viewModel as? DetailedUnitCellVM else {
            return
        }
        
        name.text = viewModel.name
        icon.image = viewModel.icon
        info.text = viewModel.info
    }
}
