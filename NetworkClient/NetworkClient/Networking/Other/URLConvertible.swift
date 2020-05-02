//
//  URLConvertible.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/11/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

public protocol URLConvertible {
    func asURL() throws -> URL
}

extension String: URLConvertible {
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else {
            throw NetworkError.invalidURL(self)
        }
        return url
    }
}

extension URL: URLConvertible {
    public func asURL() throws -> URL {
        return self
    }
}

extension URLComponents: URLConvertible {
    public func asURL() throws -> URL {
        guard let url = self.url else {
            throw NetworkError.invalidURL(self)
        }
        return url
    }
}
