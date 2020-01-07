//
//  ErrorPlaceholderView.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class ErrorPlaceholderView: UIView, ViewFromXib {
    
    // MARK: Outlets
    
    @IBOutlet private(set) var reloadButton: UIButton!
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadContentView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadContentView()
    }
}
