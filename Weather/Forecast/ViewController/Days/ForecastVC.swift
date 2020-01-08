//
//  ForecastVC.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 03/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit
import RxSwift

class ForecastVC: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private var daysWeatherView: DaysWeatherView!
    @IBOutlet private var currentWeatherView: CurrentWeatherView!
    @IBOutlet private var errorPlaceholder: ErrorPlaceholderView!
    
    // MARK: Dependencies
    
    internal var viewModel: IForecastVM!
    
    // MARK: Properties
    
    private lazy var refreshControl = RefreshControl()
    private var dispose = DisposeBag()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        view.backgroundColor = .mainBackgroundColor
        daysWeatherView.refreshControl = refreshControl
        bindViewModel()
    }
    
    private func bindViewModel() {
        let errorReload = errorPlaceholder.reloadButton.rx.tap.asObservable()
        let reload = Observable.of(rx.viewWillAppear,refreshControl.rx.delayedTriggered,errorReload).merge()
        let selected = daysWeatherView.rx.itemSelected.observeOn(MainScheduler.asyncInstance).map { $0.row }
        let output = viewModel.transform(input: Input(reload: reload, selected: selected))
        
        output.forecast.observeOn(MainScheduler.instance).subscribe(onNext: {[weak self] (viewModel) in
            self?.currentWeatherView.viewModel = viewModel.current
            self?.daysWeatherView.daysInfo = viewModel.days
        }).disposed(by: dispose)
        
        output.isErrorHidden.observeOn(MainScheduler.instance).bind(to: errorPlaceholder.rx.isHidden).disposed(by: dispose)
        output.isLoading.observeOn(MainScheduler.instance).bind(to: refreshControl.rx.isRefreshing).disposed(by: dispose)
        output.title.observeOn(MainScheduler.instance).bind(to: rx.title).disposed(by: dispose)
        output.hold.subscribe().disposed(by: dispose)
    }
}
