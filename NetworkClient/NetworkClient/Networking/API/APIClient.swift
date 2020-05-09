//
//  APIClient.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 3/17/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation
import Combine

final class APIClient {
    let transport: Transport
    let request: URLRequestable
    
    init(transport: Transport = URLSession.shared, with request: URLRequestable) {
        self.transport = transport
        self.request = request
    }
    
    func fetch<Model: Fetchable>(_ model: Model.Type = Model.self,
                                 completion: @escaping(Result<Model, Error>) -> Void) {
        guard let urlRequest = request.urlRequest else {
            completion(.failure(NetworkError.genericError("Unable to create a request \(request)")))
            return
        }
        if request.isUnderTest {
            completion(Result {
                let path = urlRequest.url?.path.replacingOccurrences(of: "/", with: "")
                return try FileReader.readDataFromFile(model,
                                                at: path).get() })
        }
        if InternetConnection.shared.isConnected == false {
            completion(.failure(NetworkError.noNetwork))
            return
        }
        transport.fetch(request: urlRequest) { data in
            completion(Result { try JSONDecoder().decode(Model.self,
                                                         from: data.get()) })
        }
    }
}

protocol Fetchable: Decodable {}
