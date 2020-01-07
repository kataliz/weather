//
//  ForecastCoordinator.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class ForecastCoordinator {
    
    // MARK: Properties
    
    private var storyboard = UIStoryboard(name: "Forecast", bundle: nil)
    private weak var navigation: UINavigationController?
    private var factory: IForecastFactory
    
    // MARK: Lifecycle
    
    init(navigation: UINavigationController, factory: IForecastFactory) {
        self.navigation = navigation
        self.factory = factory
    }
    
    // MARK: Start

    func start() {
        let forecastVC = storyboard.viewController(ForecastVC.self)
        forecastVC.viewModel = ForecastVM(adapter: factory.forecastAdapter, provider: factory.forecastProvider, storage: factory.storage, onSelect: {[weak self] (day,city) in
            self?.showDetailed(day: day, city: city)
        })
        navigation?.setViewControllers([forecastVC], animated: false)
    }
    
    // MARK: Navigate
    
    private func showDetailed(day: DayWeather, city: ForecastCity) {
        let detailedVC = storyboard.viewController(DetailedDayVC.self)
        let navigationVC = UINavigationController(rootViewController: detailedVC)
        detailedVC.viewModel = DetailedDayVM(day: day, city: city, adapter: factory.detailedAdapter, onClose: {[weak navigationVC] in
            navigationVC?.dismiss(animated: true, completion: nil)
        })
        navigation?.present(navigationVC, animated: true, completion: nil)
    }
}
