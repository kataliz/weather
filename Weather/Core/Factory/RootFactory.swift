//
//  RootFactory.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class RootFactory: IRootFactory, IForecastFactory {
    
    // MARK: Properties
    
    private lazy var queue = DispatchQueue.global(qos: .background)
    private lazy var network: INetworkService = NetworkService(sessionManager: SessionManager.default, queue: queue)
    private lazy var rxNetwork: IRxNetworkService = RxNetworkService(network: network)
    private lazy var unitFormatter: IUnitFormatter = UnitFormatter()
    private lazy var dayFormatter: IDayLocalFormatter = DayLocalFormatter()
    
    // MARK: IRootFactory
    
    var forecastFactory: IForecastFactory {
        return self
    }
    
    // MARK: IForecastFactory
    
    var forecastProvider: IForecastProvider {
       return ForecastProvider(network: rxNetwork)
    }
       
    var forecastAdapter: IForecastAdapter {
        return ForecastAdapter(dayFormatter: dayFormatter, unitFormatter: unitFormatter)
    }
    
    var detailedAdapter: IDayDetailedAdapter {
        return DayDetailedAdapter(dayFormatter: dayFormatter, unitFormatter: unitFormatter)
    }
    
    var storage: ICacheStorage {
        return CacheStorage()
    }
}
