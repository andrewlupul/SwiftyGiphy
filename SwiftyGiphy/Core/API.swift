//
//  API.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 08/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
}


protocol API {
    func get(path: String,
             completion: @escaping (Result<Data, Error>) -> Void)
    
    func get(path: String,
             parameters: [String: Any],
             completion: @escaping (Result<Data, Error>) -> Void)
    
    func request(path: String,
                 method: HTTPMethod,
                 parameters: [String: Any],
                 completion: @escaping (Result<Data, Error>) -> Void)
}


final class GiphyAPI: API {
    private let networking: Networking
    private let basePath = Constants.baseUrl
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func get(path: String,
             completion: @escaping (Result<Data, Error>) -> Void)
    {
        return request(path: path, method: .get, parameters: [:], completion: completion)
    }
    
    func get(path: String,
             parameters: [String: Any],
             completion: @escaping (Result<Data, Error>) -> Void)
    {
        return request(path: path, method: .get, parameters: parameters, completion: completion)
    }
    
    func request(path: String,
                 method: HTTPMethod,
                 parameters: [String: Any],
                 completion: @escaping (Result<Data, Error>) -> Void)
    {
        // TODO: изменить метод
        return networking.request(url: basePath + path, method: .get, parameters: parameters) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                print("Networking Error:", error.localizedDescription)
                // TODO:
                completion(.failure(CommonError.default))
            }
        }
    }
}
