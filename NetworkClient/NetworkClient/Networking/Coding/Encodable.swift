//
//  Encodable.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/11/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

extension Encodable {
    func encoded(using encoder: AnyEncoder = JSONEncoder()) throws -> Data {
        try encoder.encode(self)
    }
    func jsonObject(using encoder: AnyEncoder = JSONEncoder()) throws -> Any {
        try JSONSerialization.jsonObject(with: try encoded(using: encoder),
                                         options: .mutableContainers)
    }
}
