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
    func currentWeather(for city: String) -> Observable<ApiResult<CurrentWeather>>
    func daysForecast(for city: String) -> Observable<ApiResult<DaysForecast>>
    func forecast(for city: String) -> Observable<ApiResult<Forecast>>
}
