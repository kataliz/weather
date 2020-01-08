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
    private let scheduler: SchedulerType
    
    // MARK: Properties
    
    private let onSelect: OnDaySelected
    private let city = "Paris"
    
    // MARK: Lifecycle
    
    init(adapter: IForecastAdapter, provider: IForecastProvider, storage: ICacheStorage, scheduler: SchedulerType = MainScheduler.instance, onSelect: @escaping OnDaySelected) {
        self.adapter = adapter
        self.provider = provider
        self.storage = storage
        self.onSelect = onSelect
        self.scheduler = scheduler
    }
    
    // MARK: IForecastVM
    
    func transform(input: ForecastVC.Input) -> ForecastVC.Output {
        let reload = input.reload.debounce(.seconds(1), scheduler: scheduler).share(replay: 1).startWith(())
        let load = loadForecast(reload).share(replay: 1)
        let result = startFromCache(load).share(replay: 1)
        let forecast = result.map { $0.value }.ignoreNil().share(replay: 1)
        let isErrorHidden = showErrorOnce(result: result, loaded: forecast.toVoid(), reload: reload)
        let hold = selected(from: input.selected, forecast: forecast)
        
        return ForecastVC.Output(isLoading: loader(reload, forecast: load), title: Observable.of("\(city)"), isErrorHidden: isErrorHidden, forecast: adapted(forecast), hold: hold)
    }
    
    private func showErrorOnce(result: Observable<ApiResult<Forecast>>, loaded: Observable<Void>, reload: Observable<Void>) -> Observable<Bool> {
        let isWasValue = result.map { $0.error == nil }
        let isReloading = reload.map { _ in return true }

        return Observable.of(isWasValue,isReloading).merge().takeUntil(loaded).distinctUntilChanged()
    }
    
    private func selected(from selected: Observable<Int>, forecast: Observable<Forecast>) -> Observable<Void> {
        return selected.withLatestFrom(forecast) { (index, forecast) -> (DayWeather,ForecastCity)? in
            guard let dayWeather = forecast.days.daysWeather[safe: index] else {
                return nil
            }
            
            return (dayWeather,forecast.days.city)
        }.ignoreNil().do(onNext: onSelect).toNever()
    }
    
    private func adapted(_ forecast: Observable<Forecast>) -> Observable<ForecastInfo> {
        return Observable.combineLatest(Observable.of(adapter), forecast).map { (adapter,forecast) -> ForecastInfo in
            return adapter.transformDaysWeather(from: forecast)
        }
    }
    
    private func loader(_ load: Observable<Void>, forecast: Observable<ApiResult<Forecast>>) -> Observable<Bool> {
        return Observable.of(load.map { true },forecast.map { _ in return false }).merge()
    }
    
    private func startFromCache(_ forecast: Observable<ApiResult<Forecast>>) -> Observable<ApiResult<Forecast>> {
        guard let cached = storage.forecast(for: city) else {
            return forecast
        }
        
        return forecast.startWith(.success(cached))
    }
    
    private func loadForecast(_ load: Observable<Void>) -> Observable<ApiResult<Forecast>> {
        return load.flatMapFirst(weak: self) { (tSelf,_) -> Observable<ApiResult<Forecast>> in
            return tSelf.provider.forecast(for: tSelf.city).do(onNext: {[weak self] (results) in
                guard let `self` = self, let forecast = results.value else {
                    return
                }
                self.storage.set(forecast: forecast, for: self.city)
            })
        }
    }
}
