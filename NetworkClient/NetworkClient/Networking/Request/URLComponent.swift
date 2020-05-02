//
//  URLComponent.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/9/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

public enum HTTPScheme: String, CaseIterable {
    case http, https, ftp
}

public protocol URLComponent {
    var scheme: HTTPScheme { get }
    var base: String { get }
    var path: String { get }
    var query: Encodable? { get }
}

public extension URLComponent {
    var scheme: HTTPScheme { .https }
    var query: Encodable? { nil }
}

public extension URLComponent {
    func asURL() throws -> URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = base
        components.path = path
        if let queries = try query?.jsonObject() as? HTTPHeaders {
            queries.forEach {
                let queryItem = URLQueryItem(name: $0.key, value: $0.value)
                if components.queryItems?.append(queryItem) == nil {
                    components.queryItems = [queryItem]
                }
            }
        }
        return try components.asURL()
    }
}
