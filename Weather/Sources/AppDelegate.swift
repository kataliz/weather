//
//  AppDelegate.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 03/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: Properties
    
    private lazy var factory: RootFactory = RootFactory()

    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = UIStoryboard(name: "Forecast", bundle: nil).viewController(ForecastVC.self)
        return true
    }
}


