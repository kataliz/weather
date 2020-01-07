//
//  UIView+Appearance.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

extension UIView {
    static func applyDefaultAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.mainBackgroundColor
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for:.default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}
