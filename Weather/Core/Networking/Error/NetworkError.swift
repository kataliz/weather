//
//  NetworkError.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case parsingFailed
    
    var errorDescription: String? {
        switch self {
        case .parsingFailed: return "Parsing Failed. Maybe api changed."
        }
    }
}
