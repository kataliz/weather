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
    
    // MARK: Properties
    
    private lazy var factory: RootFactory = RootFactory()
    private var dispose = DisposeBag()
    private var adapter = DayWeatherAdapter(dayFormatter: DayLocalFormatter(), unitFormatter: UnitFormatter())
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        factory.forecastProvider.daysForecast(for: "Paris").observeOn(MainScheduler.asyncInstance).subscribe(onNext: {[weak self] (result) in
            guard let `self` = self else { return }
            if let value = result.value {
                self.daysWeatherView.daysInfo = self.adapter.transformDaysInfo(from: value)
            }
        }).disposed(by: dispose)
    }
    
    // MARK: Configure
    
    private func configure() {
        view.backgroundColor = .mainBackgroundColor
    }
}
