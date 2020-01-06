//
//  IRxNetworkService.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

typealias ApiResult<T> = Result<T>

protocol IRxNetworkService {
    func request<T: Codable>(info: ResourceInfo) -> Observable<ApiResult<T>>
}
