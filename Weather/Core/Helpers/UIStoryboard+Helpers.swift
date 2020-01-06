//
//  UIStoryboard+Helpers.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func viewController<T: UIViewController>(_ type: T.Type) -> T {
        return instantiateViewController(withIdentifier: type.className) as! T
    }
}

