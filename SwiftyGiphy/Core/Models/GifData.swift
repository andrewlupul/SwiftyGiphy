//
//  GifData.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 08/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import Foundation


struct DataResponse<T> where T: Codable {
    let data: [T]
}


extension DataResponse: Codable {}


struct GifData: Codable {
    let images: Images
}


extension GifData {
    struct Images: Codable {
        let downsized: ImageModel
        let downsizedLarge: ImageModel
        
        enum CodingKeys: String, CodingKey {
            case downsized
            case downsizedLarge = "downsized_large"
        }
    }
}


extension GifData.Images {
    struct ImageModel: Codable {
        let url: String
    }
}
