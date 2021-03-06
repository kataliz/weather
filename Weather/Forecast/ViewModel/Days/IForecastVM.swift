//
//  IForecastVM.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import RxSwift

protocol IForecastVM {
    func transform(input: ForecastVC.Input) -> ForecastVC.Output
}

extension ForecastVC {
    struct Input {
        let reload: Observable<Void>
        let selected: Observable<Int>
    }
    
    struct Output {
        let isLoading: Observable<Bool>
        let title: Observable<String>
        let isErrorHidden: Observable<Bool>
        let forecast: Observable<ForecastInfo>
        let hold: Observable<Void>
    }
}
