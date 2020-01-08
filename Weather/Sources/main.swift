//
//  main.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class TestingAppDelegate: UIResponder, UIApplicationDelegate {
  
}

let isRunningTests = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil

UIApplicationMain(CommandLine.argc,CommandLine.unsafeArgv,nil,
                   NSStringFromClass(isRunningTests ? TestingAppDelegate.self : AppDelegate.self))
