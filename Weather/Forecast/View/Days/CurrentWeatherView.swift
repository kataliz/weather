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
    
    // MARK: Public
    
    public var viewModel: CurrentWeatherInfo? {
        didSet {
            configure(viewModel: viewModel)
        }
    }
    
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
    
    private func configure(viewModel: CurrentWeatherInfo?) {
        guard let viewModel = viewModel else {
            isHidden = true
            return
        }
        temperature.text = viewModel.temperature
        icon.image = viewModel.icon
        feelsLike.text = viewModel.feelsLike
        isHidden = false
    }
}
