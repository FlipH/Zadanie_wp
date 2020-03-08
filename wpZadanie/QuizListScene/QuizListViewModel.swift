//
//  QuizListViewModel.swift
//  wpZadanie
//
//  Created by Filip Harasim on 01/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

protocol QuizListViewModelProtocol {
    var itemsCount: Int { get }
    func itemAt(indexPath: IndexPath) -> Quiz
    func loadAndStoreQuestions(completion: @escaping() -> Void)
    func loadAndStorePhoto(for indexPath: IndexPath, completion: @escaping(UIImage?) -> Void)
}

class QuizListViewModel: QuizListViewModelProtocol {

    let dataProvider: DataProviderProtocol
    var items: [Quiz] = []

    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }

    func itemAt(indexPath: IndexPath) -> Quiz {
        return items[indexPath.row]
    }

    var itemsCount: Int {
        return items.count
    }

    func loadAndStoreQuestions(completion: @escaping () -> Void) {
        dataProvider.downloadQuizzes { (result) in
            switch result {
            case .success(let data):
                self.items = data
                completion()
            case .failure(_): break
            }
        }
    }

    func loadAndStorePhoto(for indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        guard let url = itemAt(indexPath: indexPath).mainPhoto?.url else {
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
