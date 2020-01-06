//
//  NetworkService.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService: INetworkService {
    
    // MARK: Dependencies
    
    private let sessionManager: SessionManager
    private let queue: DispatchQueue
    
    // MARK: Lifecycle
    
    init(sessionManager: SessionManager, queue: DispatchQueue) {
        self.sessionManager = sessionManager
        self.queue = queue
    }
    
    // MARK: INetworkProvider
    
    func request<T: Decodable>(info: ResourceInfo, completion: @escaping ApiResponse<T>) {
        let request = constructRequest(info: info)
        
        request.validate().processResponse(queue: queue, completion)
    }
    
    private func constructRequest(info: ResourceInfo) -> DataRequest {
        let encoding: ParameterEncoding = (info.method == .get) ? URLEncoding.default : JSONEncoding.default
        
        return sessionManager.request(info.path.url, method: info.method,
                                      parameters: info.parameters, encoding: encoding,
                                      headers: info.headers)
    }
}
