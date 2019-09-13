//
//  Error.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 08/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import Foundation


enum NetworkingError: Error {
    case wrongURL
    case wrongParameterType
    case statusCode(Int)
}


enum CommonError: Error {
    case `default`
    
    var localizedDescription: String {
        switch self {
        case .default: return "Something went wrong"
        }
    }
}
