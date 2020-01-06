//
//  UITableView+Helpers.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

extension UITableView {
    func register(cell: UITableViewCell.Type) {
        let name = cell.className
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func dequeueCell<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: cell.className, for: indexPath) as! T
    }
}
