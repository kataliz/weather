//
//  NSObject+className.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
