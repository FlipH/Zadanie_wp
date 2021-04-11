//
//  NetworkClient+Endpoints.swift
//  wpZadanie
//
//  Created by Filip Harasim on 29/02/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import Foundation


extension NetworkClient {
    enum Endpoint {
        case quizList
        case quizDetail(Int)

        var path: String {
            switch self {
            case .quizList: return "quizzes/0/100"
            case .quizDetail(let id): return "quiz/\(id)/0"
            }
        }
    }
}
