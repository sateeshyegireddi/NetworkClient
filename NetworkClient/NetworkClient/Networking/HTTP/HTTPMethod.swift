//
//  HTTPMethod.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/9/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case HEAD
    case PATCH
    case TRACE
    case CONNECT
    case OPTIONS
    
    public var value: String {
        return self.rawValue
    }
}
