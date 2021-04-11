//
//  QuizListViewController.swift
//  wpZadanie
//
//  Created by Filip Harasim on 01/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

class QuizListViewController: UIViewController {

    var viewModel: QuizListViewModelProtocol!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        activityIndicatorView.isHidden = false

        viewModel.loadAndStoreQuestions {
            DispatchQueue.main.async {
                self.activityIndicatorView.isHidden = true
                self.tableView.reloadData()
            }
        }
    }

}

extension QuizListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizListTableViewCell.reuseIdentifier) as? QuizListTableViewCell else {
            return UITableViewCell()
        }
        cell.imageActivityIndicatorView.isHidden = false
        viewModel.loadAndStorePhoto(for: indexPath) { (image) in
            cell.imageActivityIndicatorView.isHidden = true
            cell.imageV.image = image
        }

        cell.quizName?.text = viewModel.itemAt(indexPath: indexPath).title
        cell.categoryName?.text = "Kategoria: \(viewModel.itemAt(indexPath: indexPath).category.name)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = QuizViewController.instantiate() else {
            return
        }
        let id = viewModel.itemAt(indexPath: indexPath).id
        let dataProv = DataProvider(client: NetworkClient())
        vc.viewModel = QuizViewModel(id: id, dataProvider: dataProv)

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension QuizListViewController: StoryboardLoadable {
    static var storyboardName = "QuizList"
}
