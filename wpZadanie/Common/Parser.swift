//
//  Parser.swift
//  wpZadanie
//
//  Created by Filip Harasim on 29/02/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import Foundation

class Parser {
    static func decode<T: Decodable>(model: T.Type, data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(model, from: data)
            return decodedData
        } catch let err {
            print(err.localizedDescription)
        }
        return nil
    }
    static func encode<T: Encodable>(data: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let encodedData = try encoder.encode(data)
            return encodedData
        } catch let err {
            print(err.localizedDescription)
        }
        return nil
    }
}
