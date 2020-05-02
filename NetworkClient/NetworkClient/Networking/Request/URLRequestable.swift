//
//  APIRequest.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/5/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation
import Combine

public protocol URLRequestable {
    var method: HTTPMethod { get }
    var body: DataConvertible? { get }
    var headers: HTTPHeaders? { get }
    var isUnderTest: Bool { get }
    var dispatchGroup: DispatchGroup? { get }
    var urlRequest: URLRequest? { get }
    var urlComponent: URLComponent { get }
}

extension URLRequestable {
    public var method: HTTPMethod { .GET }
    public var body: DataConvertible? { nil }
    public var headers: HTTPHeaders? { HTTPHeaderField.default }
    public var isUnderTest: Bool { false }
    public var dispatchGroup: DispatchGroup? { nil }
    public var urlRequest: URLRequest? {
        return try? URLRequest(url: urlComponent,
                               method: method,
                               body: body,
                               headers: headers)
    }
}

extension URLRequest {
    fileprivate init(url: URLComponent,
                     method: HTTPMethod = .GET,
                     body: DataConvertible? = nil,
                     headers: HTTPHeaders? = HTTPHeaderField.default) throws {
        let url = try url.asURL()
        self.init(url: url)
        httpMethod = method.value
        httpBody   = try body?.asData()
        if let headers = headers {
            for (headerField, headerValue) in headers {
                setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
    }
}
