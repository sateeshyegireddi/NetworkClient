//
//  User.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/5/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Fetchable {
    var resultCount: Int
    var result: T
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case result = "results"
    }
}

struct Artist: Codable {
    var trackId: Int
    var artistName: String
    var artworkUrl100: String
}
