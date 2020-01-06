//
//  RxNetworkService.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class RxNetworkService: IRxNetworkService {
    
    // MARK: Dependencies
    
    private var network: INetworkService
    
    // MARK: Lifecycle
    
    init(network: INetworkService) {
        self.network = network
    }
    
    // MARK: IRxNetworkProvider
    
    func request<T: Codable>(info: ResourceInfo) -> Observable<ApiResult<T>> {
        return Observable<ApiResult<T>>.create({[weak self] (observer) -> Disposable in
            self?.network.request(info: info, completion: { (result: Result<T>) in
                observer.onNext(result)
                observer.onCompleted()
            })
            
            return Disposables.create()
        })
    }
}
