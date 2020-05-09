//
//  HTTPResponseError.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/9/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case request
    case server
    case noNetwork
    case invalidURL(URLConvertible)
    case jsonParse
    case genericError(Any)
    var description: String {
        switch self {
        case .request:
            return "The request failed due to an error in the request."
        case .server:
            return "The request failed due to a server-side error."
        case .noNetwork:
            return "It seems the device is not connected to internet. Please check your internet connection."
        case .invalidURL(let url):
            return "Invalid URL: \(url)."
        case .jsonParse:
            return "There is an error occured while parsing JSON data."
        case .genericError(let any):
            return "Error occured: \(any)"
        }
    }
}
