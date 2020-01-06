//
//  INetworkService.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import Alamofire

typealias ApiResponse<T> = (Result<T>) -> Void

protocol INetworkService {
    func request<T: Decodable>(info: ResourceInfo, completion: @escaping ApiResponse<T>)
}
