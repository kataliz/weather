//
//  DataRequest+Response.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import Alamofire

extension Alamofire.DataRequest {
    func processResponse<T: Decodable>(queue: DispatchQueue, _ completion: @escaping ApiResponse<T>) {
        self.responseData(queue: queue) { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                guard let object: T = try? decoder.decode(T.self, from: data) else {
                    completion(.failure(NetworkError.parsingFailed))
                    return
                }
                completion(.success(object))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
