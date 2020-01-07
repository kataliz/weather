//
//  DetailedDayVM.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import RxSwift

class DetailedDayVM: IDetailedDayVM {
    
    // MARK: Properties
    
    private var day: DayWeather
    private var city: ForecastCity
    private var onClose: EmptyCallback
    
    // MARK: Dependencies
    
    private var adapter: IDayDetailedAdapter
    
    // MARK: Lifecycle
    
    init(day: DayWeather, city: ForecastCity, adapter: IDayDetailedAdapter, onClose: @escaping EmptyCallback) {
        self.day = day
        self.city = city
        self.adapter = adapter
        self.onClose = onClose
    }
    
    // MARK: IDetailedDayVM
    
    func transform(input: DetailedDayVC.Input) -> DetailedDayVC.Output {
        let hold = input.tapOnClose.do(onNext: onClose).toNever()
        let title = Observable.of(adapter.dayName(dayInfo: day, for: city))
        let detailedCellsVM = Observable.of(adapter.transform(dayInfo: day, for: city))
        return DetailedDayVC.Output(title: title, dayDetailed: detailedCellsVM, hold: hold)
    }
}
