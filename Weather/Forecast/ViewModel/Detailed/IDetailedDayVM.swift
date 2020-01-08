//
//  IDetailedDayVM.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import RxSwift

protocol IDetailedDayVM {
    func transform(input: DetailedDayVC.Input) -> DetailedDayVC.Output
}

extension DetailedDayVC {
    struct Input {
        let tapOnClose: Observable<Void>
    }
    
    struct Output {
        let title: Observable<String>
        let dayDetailed: Observable<[DayDetailedCellInfo]>
        let hold: Observable<Void>
    }
}
