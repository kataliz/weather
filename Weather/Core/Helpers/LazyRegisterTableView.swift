//
//  LazyRegisterTableView.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class LazyRegisterTableView: UITableView {
    
    // MARK: Properties
    
    private var registeredCells = Set<String>()
    
    // MARK: UITableView
    
    override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
        if !registeredCells.contains(identifier) {
            register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
        
        return super.dequeueReusableCell(withIdentifier: identifier)
    }
}
