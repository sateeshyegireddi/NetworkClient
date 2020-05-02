//
//  APITransport.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/5/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation
import Combine

public typealias ServiceHandler = ((Result<Data, Error>) -> Void)

public protocol Transport {
    func fetch(request: URLRequest, completion: @escaping ServiceHandler)
}

extension URLSession: Transport {
    public func fetch(request: URLRequest, completion: @escaping ServiceHandler) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: request) { (data, response, error) in
            #if DEBUG
            let httpUrlResponse = response as? HTTPURLResponse
            self.logSession(log: true,
                            request: request,
                            response: httpUrlResponse,
                            error: error,
                            data: data)
            #endif
            if let error = error {
                completion(.failure(error))
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if (400..<499 ~= statusCode) {
                    completion(.failure(NetworkError.request))
                } else if (500..<599 ~= statusCode) {
                    completion(.failure(NetworkError.server))
                }
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
    func logSession(log: Bool,
                    request: URLRequest?,
                    response: HTTPURLResponse?,
                    error: Error?,
                    data: Data?) {
        if log == false && error == nil && (200..<300).contains(response?.statusCode ?? 0) {
            return
        }
        if request != nil, let url = try? request?.url?.asURL() {
            print("\(request?.httpMethod ?? "URL"):\t\t\(url)")
        }
        if let headers = request?.allHTTPHeaderFields, !headers.isEmpty {
            print("Header:\t\t\(headers)")
        }
        if let data = request?.httpBody, !data.isEmpty {
            print("Body:\t\tSize: \(data)\n\(data.prettyPrittedString)")
        }
        if let statusCode = response?.statusCode {
            print("Status Code: \t\(statusCode)")
        }
        if let data = data, !data.isEmpty {
            print("Response:\t\tSize: \(data)\n\(data.prettyPrittedString.replacingOccurrences(of: "\\/", with: "/"))")
        }
        if let error = error {
            print("Error:\t\t\(error.localizedDescription)")
        }
    }
}
