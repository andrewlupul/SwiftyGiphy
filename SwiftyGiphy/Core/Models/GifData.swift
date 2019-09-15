//
//  GifData.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 08/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import Foundation


struct GifData: Codable {
    let images: Images
    let user: User?
}


extension GifData {
    struct Images: Codable {
        let downsizedLarge: ImageModel
        
        enum CodingKeys: String, CodingKey {
            case downsizedLarge = "downsized_large"
        }
    }
    
    struct User: Codable {
        let username: String
        let avatarUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case username
            case avatarUrl = "avatar_url"
        }
    }
}


extension GifData.Images {
    struct ImageModel: Codable {
        let url: URL
        let height: String
        let width: String
    }
}
