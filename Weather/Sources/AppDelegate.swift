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
    
    private var coordinator: RootCoordinator?

    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else {
            return false
        }
        
        UIView.applyDefaultAppearance()
        
        coordinator = RootCoordinator(factory: RootFactory(), window: window)
        coordinator?.start()

        return true
    }
}


