//
//  JsonSample.swift
//  wpZadanie
//
//  Created by Filip Harasim on 07/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import Foundation

func readJSONFromFile<T: Decodable>(fileName: String) -> T {
    var parsedData: T? = nil
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let fileURL = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: fileURL, options: .mappedRead)
            parsedData = Parser.decode(model: T.self, data: data)!

        } catch {
            print("error")
        }
    }
    return parsedData!
}
