//
//  DataResponse.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 15/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import Foundation


struct DataResponse<T> where T: Codable {
    let data: [T]
    let meta: Meta?
}


extension DataResponse: Codable {
    struct Meta: Codable {
        let status: Int?
        let msg: String?
    }
}
