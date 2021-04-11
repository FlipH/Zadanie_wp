//
//  AnswerModel.swift
//  wpZadanie
//
//  Created by Filip Harasim on 29/02/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import Foundation

struct QuizDetails: Codable {
    var title: String
    var questions: [QuizQuestion]
    var rates: [Rate]
}

struct QuizQuestion: Codable {
    var text: String
    var image: PhotoData
    var answers: [QuizAnswer]
    //Answer type- text or ?? Image
    var answer: String
    var type: String
}

struct QuizAnswer: Codable {
    var image: PhotoData
    var order: Int
    var text: String
    var isCorrect: Bool?

    init(image: PhotoData, order: Int, text: String, isCorrect: Bool) {
        self.image = image
        self.order = order
        self.text = text
        self.isCorrect = isCorrect
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decode(PhotoData.self, forKey: .image)
        order = try values.decode(Int.self, forKey: .order)
        if values.contains(.isCorrect) {
          //  let value = try values.decode(Int.self, forKey: .isCorrect)
            isCorrect = true
        }
        if let value = try? values.decode(Int.self, forKey: .text) {
            text = String(value)
        } else {
            text = try values.decode(String.self, forKey: .text)
        }
    }
}

struct Rate: Codable {
    var from: Int
    var to: Int
    var content: String
}

struct PhotoData: Codable {
    var url: String?
}
