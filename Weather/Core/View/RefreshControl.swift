//
//  RefreshControl.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class RefreshControl: UIRefreshControl {
    
    // MARK: Lifecycle
    
    convenience override init() {
        self.init(frame: CGRect(x: 0.0, y: 0.0, width: 60.0, height: 60.0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        tintColor = UIColor.textColor
    }
}
