//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView, ViewFromXib {
    
    // MARK: Outlets
    
    @IBOutlet private var background: UIView!
    @IBOutlet private var temperature: UILabel!
    @IBOutlet private var feelsLike: UILabel!
    @IBOutlet private var icon: UIImageView!
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadContentView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadContentView()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        isHidden = true
    }
    
    public func configure(viewModel: CurrentWeatherVM) {
        temperature.text = viewModel.temperature
        icon.image = viewModel.icon
        feelsLike.text = viewModel.feelsLike
        isHidden = false
    }
}
