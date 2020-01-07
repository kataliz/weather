//
//  ForecastProvider.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class ForecastProvider: IForecastProvider {
    
    // MARK: Properties
    
    private var appId = "648a3aac37935e5b45e09727df728ac2"
    
    // MARK: Dependencies
    
    private var network: IRxNetworkService
    
    // MARK: Lifecycle
    
    init(network: IRxNetworkService) {
        self.network = network
    }
    
    // MARK: IForecastProvider
    
    func forecast(for city: String) -> Observable<ApiResult<Forecast>> {
       return Observable.zip(currentWeather(for: city), daysForecast(for: city)).map { (current,days) -> ApiResult<Forecast> in
           if let current = current.value, let days = days.value {
               return .success(Forecast(current: current, days: days))
           } else {
               return .failure(current.error ?? days.error ?? NetworkError.parsingFailed)
           }
       }
   }
    
    func currentWeather(for city: String) -> Observable<ApiResult<CurrentWeather>> {
        let parameters = defaultParameters(for: city)
        return network.request(info: ResourceInfo(path: ForecastApiPath.current, parameters: parameters))
    }
    
    func daysForecast(for city: String) -> Observable<ApiResult<DaysForecast>> {
        var parameters = defaultParameters(for: city)
        parameters["cnt"] = 16
        return network.request(info: ResourceInfo(path: ForecastApiPath.byDays, parameters: parameters))
    }
    
    private func defaultParameters(for city: String) -> Parameters {
        return ["q": city, "mode": "json", "units": "metric", "APPID": appId]
    }
}
