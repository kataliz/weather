//
//  DaysWeatherView.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class DaysWeatherView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Public
    
    public var daysInfo = [DayWeatherInfo]() {
        didSet {
            reloadData()
        }
    }
    
    // MARK: Lifecycle
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        allowsMultipleSelection = false
        delegate = self
        dataSource = self
        backgroundColor = .mainBackgroundColor
        rowHeight = 79.0
        register(cell: DayWeatherCell.self)
    }
    
    // MARK: UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(DayWeatherCell.self, for: indexPath)
        cell.configure(viewModel: daysInfo[indexPath.row])
        return cell
    }
}
