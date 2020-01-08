//
//  MockForecastProvider.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import RxTest
import RxSwift
@testable import Weather

class MockForecastProvider: IForecastProvider {
    
    // MARK: Properties
    
    private var current = PublishSubject<ApiResult<Forecast>>()
    
    // MARK: Configure
    
    func configure(with: Forecast) {
        current.onNext(ApiResult.success(with))
    }
    
    func configure(error: Error) {
        current.onNext(ApiResult.failure(error))
    }
    
    func clear() {
        current = PublishSubject<ApiResult<Forecast>>()
    }
    
    // MARK: IForecastProvider
    
    func forecast(for city: String) -> Observable<ApiResult<Forecast>> {
        current.onCompleted()
        current = PublishSubject<ApiResult<Forecast>>()
        return current.asObservable()
    }
}
