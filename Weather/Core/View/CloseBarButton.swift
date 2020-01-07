//
//  CloseButton.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit
import RxSwift

class CloseBarButton: UIBarButtonItem {
    
    // MARK: Lifecycle
    
    convenience init(style: UIBarButtonItem.Style) {
        self.init(image: #imageLiteral(resourceName: "close_icon"), style: style, target: nil, action: nil)
        tintColor = UIColor.textColor
    }
}
