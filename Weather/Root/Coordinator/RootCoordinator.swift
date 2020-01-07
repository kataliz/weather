//
//  RootCoordinator.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class RootCoordinator {
    
    // MARK: Properties
    
    private var factory: IRootFactory
    private weak var window: UIWindow?
    private var forecastCoordinator: ForecastCoordinator?
    
    // MARK: Lifecycle
    
    init(factory: IRootFactory, window: UIWindow) {
        self.factory = factory
        self.window = window
    }
    
    // MARK: Start
    
    func start() {
        let navigationVC = UINavigationController()
        window?.rootViewController = navigationVC
        
        forecastCoordinator = ForecastCoordinator(navigation: navigationVC, factory: factory.forecastFactory)
        forecastCoordinator?.start()
    }
}
