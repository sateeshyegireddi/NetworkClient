//
//  AnyDecoder.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/11/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

public protocol AnyDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: AnyDecoder { }

public extension Data {
    func decoded<T: Decodable>(using decoder: AnyDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(T.self, from: self)
    }
    var prettyPrittedString: String {
        if let object = try? JSONSerialization.jsonObject(with: self,
                                                          options: .mutableLeaves),
            JSONSerialization.isValidJSONObject(object),
            let data = try? JSONSerialization.data(withJSONObject: object,
                                                   options: .prettyPrinted) {
            return String(decoding: data, as: UTF8.self)
        } else {
            return String(decoding: self, as: UTF8.self)
        }
    }
}
