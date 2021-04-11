//
//  QuizViewModel.swift
//  wpZadanie
//
//  Created by Filip Harasim on 03/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

enum QuizAnswerResult {
    case correct
    case incorrect
}

protocol QuizViewModelProtocol {
    var answerSelected: Int? { get set }
    var currentQuestion: Int { get set }
    var quizTitle: String { get }
    var questionsCount: Int { get }
    var quizResult: Float { get }
    func validateAnswer(completion: (QuizAnswerResult) -> Void)
    func loadDetails(completion: @escaping() -> Void)
    func getRates() -> [Rate]
    func getQuestionFor(indexPath: IndexPath) -> QuizQuestion?
    func loadAndStorePhoto(for indexPath: IndexPath, completion: @escaping(UIImage?) -> Void)
}


class QuizViewModel: QuizViewModelProtocol {

    let dataProvider: DataProviderProtocol
    let id: Int
    var currentQuestion = 0
    var answerSelected: Int? = nil
    var correctAnswersCount = 0

    init(id: Int, dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
        self.id = id
    }

    private var items: QuizDetails? = nil

    func loadDetails(completion: @escaping () -> Void) {
        dataProvider.downloadDetailForQuiz(with: id) { (result) in
            switch result {
            case .success(let data):
                self.items = data
                completion()
            case .failure(_):
                //TODO: Handle error
                break
            }
        }
    }

    var quizTitle: String {
        return items?.title ?? ""
    }

    var questionsCount: Int {
        return items?.questions.count ?? 0
    }

    var quizResult: Float {
        return Float(correctAnswersCount) / Float(questionsCount) * 100
    }

    func getRates() -> [Rate] {
        return items?.rates ?? []
    }


    func getQuestionFor(indexPath: IndexPath) -> QuizQuestion?  {
        return items?.questions[indexPath.row] ?? nil
    }

    func validateAnswer(completion: (QuizAnswerResult) -> Void) {
        guard currentQuestion < questionsCount else {
            return
        }
        if let answerSelected = answerSelected {
            if (getQuestionFor(indexPath: IndexPath(row: currentQuestion, section: 0))?.answers[answerSelected].isCorrect) != nil {
                correctAnswersCount += 1
                completion(.correct)
            } else {
                completion(.incorrect)
            }
        }
    }

    func loadAndStorePhoto(for indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = getQuestionFor(indexPath: indexPath)?.image.url, let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        dataProvider.downloadPhoto(for: url) { (result) in
            switch result {
            case .success(let image):
                completion(image)
                break
            case .failure(_):
                completion(nil)
                break
            }
        }
    }
}
