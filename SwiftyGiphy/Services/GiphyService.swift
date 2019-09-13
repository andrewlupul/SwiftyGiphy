//
//  GiphyService.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 08/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import Foundation


protocol GiphyService {
    func getTrends(completion: @escaping (Result<[GifData], Error>) -> Void)
}


final class GiphyServiceImpl {
    private let api: API
    
    init(api: API) {
        self.api = api
    }
}


extension GiphyServiceImpl: GiphyService {
    func getTrends(completion: @escaping (Result<[GifData], Error>) -> Void) {
        // TODO: Вынести?
        let parameters = ["api_key": Constants.apiKey, "limit": 10, "rating": "G"] as [String : Any]
        
        api.get(path: "/trending", parameters: parameters) { result in
            completion(
                result
                    .flatMap { data in
                        do {
                            let dataResponse = try JSONDecoder().decode(DataResponse<GifData>.self, from: data)
                            return .success(dataResponse.data)
                        } catch {
                            return .failure(error)
                        }
                    }
                    .mapError { _ in return CommonError.default }
            )
        }
    }
}
