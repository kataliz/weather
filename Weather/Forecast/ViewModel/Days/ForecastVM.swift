//
//  ForecastVM.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import RxSwift

typealias OnDaySelected = (DayWeather,ForecastCity) -> Void

class ForecastVM: IForecastVM {
    
    // MARK: Dependencies
    
    private var storage: ICacheStorage
    private let adapter: IForecastAdapter
    private let provider: IForecastProvider
    
    // MARK: Properties
    
    private let onSelect: OnDaySelected
    private let city = "Paris"
    
    // MARK: Lifecycle
    
    init(adapter: IForecastAdapter, provider: IForecastProvider, storage: ICacheStorage, onSelect: @escaping OnDaySelected) {
        self.adapter = adapter
        self.provider = provider
        self.storage = storage
        self.onSelect = onSelect
    }
    
    // MARK: IForecastVM
    
    func transform(input: ForecastVC.Input) -> ForecastVC.Output {
        let reload = input.reload.share(replay: 1)
        let forecast = loadForecast(reload).share(replay: 1)
        let isLoading = loader(reload, forecast: forecast)
        let result = startFromCach(forecast).share(replay: 1)
        let error = result.map { $0.error }.ignoreNil()
        let forecastValue = result.map { $0.value }.ignoreNil().share(replay: 1)
        let daysValue = days(from: forecastValue)
        let currentValue = current(from: forecastValue)
        let title = Observable.of("\(city)")
        let hold = selected(from: input.selected, forecast: forecastValue)
        
        return ForecastVC.Output(isLoading: isLoading, title: title, error: error, current: currentValue, days: daysValue, hold: hold)
    }
    
    private func selected(from selected: Observable<Int>, forecast: Observable<Forecast>) -> Observable<Void> {
        return selected.withLatestFrom(forecast) { (index, forecast) -> (DayWeather,ForecastCity)? in
            guard let dayWeather = forecast.days.daysWeather[safe: index] else {
                return nil
            }
            
            return (dayWeather,forecast.days.city)
        }.ignoreNil().do(onNext: onSelect).toNever()
    }
    
    private func days(from forecast: Observable<Forecast>) -> Observable<[DayWeatherCellVM]> {
        return Observable.combineLatest(Observable.of(adapter), forecast).map { (adapter,forecast) -> [DayWeatherCellVM] in
            return adapter.transformDaysCellVM(from: forecast.days)
        }
    }
    
    private func current(from forecast: Observable<Forecast>) -> Observable<CurrentWeatherVM> {
        return Observable.combineLatest(Observable.of(adapter), forecast).map { (adapter,forecast) -> CurrentWeatherVM in
            return adapter.transformCurrentVM(from: forecast.current)
        }
    }
    
    private func loader(_ load: Observable<Void>, forecast: Observable<ApiResult<Forecast>>) -> Observable<Bool> {
        return Observable.of(load.map { true },forecast.map { _ in return false }).merge()
    }
    
    private func startFromCach(_ forecast: Observable<ApiResult<Forecast>>) -> Observable<ApiResult<Forecast>> {
        guard let cached = storage.forecast(for: city) else {
            return forecast
        }
        
        return forecast.startWith(.success(cached))
    }
    
    private func loadForecast(_ load: Observable<Void>) -> Observable<ApiResult<Forecast>> {
        return load.flatMap(weak: self) { (tSelft,_) -> Observable<ApiResult<Forecast>> in
            return tSelft.provider.forecast(for: tSelft.city).do(onNext: {[weak self] (results) in
                guard let `self` = self, let forecast = results.value else {
                    return
                }
                self.storage.set(forecast: forecast, for: self.city)
            })
        }
    }
}
