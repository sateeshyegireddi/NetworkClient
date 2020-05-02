//
//  APIEndPoint.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/5/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

enum BaseURL: String {
    case base = "itunes.apple.com"
}

enum URLPath: String {
    case search = "/search"
}

enum URLQueryKeys: String {
    case term = "term"
    case country = "country"
}
