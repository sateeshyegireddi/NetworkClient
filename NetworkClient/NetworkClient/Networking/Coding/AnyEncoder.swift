//
//  AnyEncoder.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/11/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

protocol AnyEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: AnyEncoder {}
