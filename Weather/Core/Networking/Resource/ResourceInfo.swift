//
//  ResourceInfo.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import Alamofire

struct ResourceInfo {
    
    // MARK: Properties
    
    let path: IApiPath
    let parameters: Parameters?
    let method: HTTPMethod
    let headers: HTTPHeaders?
    
    // MARK: Lifecycle
    
    init(path: IApiPath, parameters: Parameters? = nil, method: HTTPMethod = .get, headers: HTTPHeaders? = nil) {
        self.path = path
        self.parameters = parameters
        self.method = method
        self.headers = headers
    }
}
