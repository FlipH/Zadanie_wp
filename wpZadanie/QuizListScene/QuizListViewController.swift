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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(QuizListTableViewCell.self, forCellReuseIdentifier: QuizListTableViewCell.reuseIdentifier)
        
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
        cell.quizName?.text = viewModel.itemAt(indexPath: indexPath).title
        cell.categoryName?.text = viewModel.itemAt(indexPath: indexPath).category.name

        return cell
    }
}

extension QuizListViewController: StoryboardLoadable {
    static var storyboardName = "QuizList"
}
