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
    var image: PhotoData
    var answers: [QuizAnswer]
    //Answer type- text or ?? Image
    var answer: String
}

struct QuizAnswer: Codable {
    var image: PhotoData
    var order: Int
    var text: String
    var isCorrect: Int?

    //Improvement- decoder for isCorrect as Bool
}

struct Rate: Codable {
    let from: Int
    let to: Int

}

struct PhotoData: Codable {
    var url: URL
}
