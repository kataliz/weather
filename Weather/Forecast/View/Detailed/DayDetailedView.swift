//
//  DayDetailedView.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class DayDetailedView: LazyRegisterTableView, UITableViewDataSource, UITableViewDelegate {

    // MARK: Public
    
    public var detailedList = [DayDetailedCellVM]() {
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
        delegate = self
        dataSource = self
        backgroundColor = .mainBackgroundColor
        rowHeight = UITableView.automaticDimension
    }
    
    // MARK: UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = detailedList[indexPath.row]
        let cell = dequeueCell(viewModel.cell, for: indexPath)
        cell.configure(viewModel: viewModel)
        
        return cell
    }
}

