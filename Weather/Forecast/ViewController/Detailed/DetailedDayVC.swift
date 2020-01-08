//
//  DetailedDayVC.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit
import RxSwift

class DetailedDayVC: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private var detailedView: DayDetailedView!
    
    // MARK: Dependencies
    
    internal var viewModel: IDetailedDayVM!
    
    // MARK: Properties
    
    private lazy var closeButton = CloseBarButton(style: .plain)
    private var dispose = DisposeBag()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        view.backgroundColor = .mainBackgroundColor
        navigationItem.rightBarButtonItem = closeButton
        bindViewModel()
    }
    
    private func bindViewModel() {
        let onClose = closeButton.rx.tap.asObservable()
        let output = viewModel.transform(input: Input(tapOnClose: onClose))
        
        output.dayDetailed.bind(to: detailedView.rx.detailedList).disposed(by: dispose)
        output.title.bind(to: rx.title).disposed(by: dispose)
        output.hold.subscribe().disposed(by: dispose)
    }
}
