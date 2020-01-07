//
//  UIView+Constraints.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

extension UIView {
    func placeMargins(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(subview, at: 0)
        
        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([subview.topAnchor.constraint(equalTo: margins.topAnchor),
                                     subview.leftAnchor.constraint(equalTo: margins.leftAnchor),
                                     subview.rightAnchor.constraint(equalTo: margins.rightAnchor),
                                     subview.bottomAnchor.constraint(equalTo: margins.bottomAnchor)])
    }
}
