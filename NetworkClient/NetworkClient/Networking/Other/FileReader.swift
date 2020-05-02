//
//  FileReader.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/5/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

struct ReadFileError: Error, CustomStringConvertible {
    var description: String
    init(_ message: String) {
        self.description = message
    }
}

struct FileReader {
    static func readDataFromFile<Model: Fetchable>(_ model: Model.Type = Model.self,
                                                   at filePath: String?) throws -> Result<Model, ReadFileError> {
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: filePath, ofType: "json") else {
            throw ReadFileError("FileLoader.readDataFromFile(at \(filePath ?? "X"): No file found at path.")
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            throw ReadFileError("FileLoader.readDataFromFile(at \(filePath ?? "X"): Unable convert the content into data.")
        }
        do {
            let model = try JSONDecoder().decode(model.self, from: data)
            return .success(model)
        } catch {
            throw ReadFileError("FileLoader.readDataFromFile(at \(filePath ?? "X"): Unable parse JSON data from file.")
        }
    }
}
