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
    
    func daysForecast(for city: String) -> Observable<ApiResult<DaysForecast>> {
        let parameters: Parameters = ["q": city, "mode": "json", "units": "metric", "cnt": 16, "APPID": appId]
        return network.request(info: ResourceInfo(path: ForecastApiPath.byDays, parameters: parameters))
    }
}
