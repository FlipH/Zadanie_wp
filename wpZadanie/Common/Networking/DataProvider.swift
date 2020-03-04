//
//  DataProvider.swift
//  wpZadanie
//
//  Created by Filip Harasim on 29/02/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

protocol DataProviderProtocol {
    var networkClient: NetworkClientProtocol { get }
    func downloadQuizzes(completion: @escaping(Result<[Quiz], Error>) -> Void)
    func downloadDetailForQuiz(with id: Int, completion: @escaping (Result<QuizDetails, Error>) -> Void)
    func downloadPhoto(for url: URL, completion: @escaping(Result<UIImage, Error>) -> Void)
}

class DataProvider: DataProviderProtocol {

    let imageCache: ImageCacheProtocol = ImageCache()
    let networkClient: NetworkClientProtocol

    init(client: NetworkClientProtocol) {
        self.networkClient = client
    }

    func downloadQuizzes(completion: @escaping (Result<[Quiz], Error>) -> Void) {
        networkClient.downloadData(for: .quizList) { (result) in
            switch result {
            case .failure(let err):
                completion(.failure(err))
            case .success(let data):
                guard let parsedData = Parser.decode(model: QuizModel.self, data: data) else {
                    completion(.failure(NetworkError.decodingFailure))
                    return
                }
                completion(.success(parsedData.quizess))
            }
        }
    }

    //TODO: posibility for improvement- code duplication
    func downloadDetailForQuiz(with id: Int, completion: @escaping (Result<QuizDetails, Error>) -> Void) {
        networkClient.downloadData(for: .quizDetail(id)) { (result) in
            switch result {
            case .failure(let err):
                completion(.failure(err))
            case .success(let data):
                guard let parsedData = Parser.decode(model: QuizDetails.self, data: data) else {
                    completion(.failure(NetworkError.decodingFailure))
                    return
                }
                completion(.success(parsedData))
            }
        }
    }

    func downloadPhoto(for url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        networkClient.downloadPhoto(for: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        completion(.failure(NetworkError.missingData))
                        return
                    }
                    self.imageCache.setObject(object: image, for: url.absoluteString)
                    completion(.success(image))
                }
            }

        }
    }
}
