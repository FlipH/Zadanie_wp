//
//  QuestionModel.swift
//  wpZadanie
//
//  Created by Filip Harasim on 29/02/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import Foundation


struct QuizModel: Codable {
    let quizess: [Quiz]

    enum CodingKeys: String, CodingKey {
        case quizess = "items"
    }
}


struct Quiz: Codable {
    let title: String
    let id: Int
    let category: QuizCategory
    let mainPhoto: MainPhoto?
}

struct MainPhoto: Codable {
    let url: URL
}

struct QuizCategory: Codable {
    let name: String
}
