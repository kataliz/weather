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

class RootFactory {
    
    // MARK: Properties
    
    private lazy var queue = DispatchQueue.global(qos: .background)
    private lazy var network: INetworkService = NetworkService(sessionManager: SessionManager.default, queue: queue)
    private lazy var rxNetwork: IRxNetworkService = RxNetworkService(network: network)
    
    // MARK: Public
    
    public var forecastProvider: IForecastProvider {
        return ForecastProvider(network: rxNetwork)
    }
}
