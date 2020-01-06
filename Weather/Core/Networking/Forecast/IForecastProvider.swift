//
//  IForecastProvider.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import RxSwift

protocol IForecastProvider {
    func daysForecast(for city: String) -> Observable<ApiResult<DaysForecast>>
}
