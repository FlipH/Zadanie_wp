//
//  QuizViewController.swift
//  wpZadanie
//
//  Created by Filip Harasim on 03/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit


class QuizViewController: UIViewController {

    var viewModel: QuizViewModelProtocol!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(QuestionCollectionViewCell.self, forCellWithReuseIdentifier: QuestionCollectionViewCell.reuseIdentifier)

        activityIndicatorView.isHidden = false

        viewModel.loadDetails {
            DispatchQueue.main.async {
            self.progressView.divider = self.viewModel.questionsCount
            self.activityIndicatorView.isHidden = true
            self.collectionView.reloadData()
            self.titleLabel.text = self.viewModel.quizTitle
            }
        }
    }

    @IBAction func continueQuiz(_ sender: UIButton) {
        guard isCellAlreadySelected() else { return }
        guard viewModel.currentQuestion < viewModel.questionsCount - 1 else {
            //SHOW RESULT
            guard let vc = ResultViewController.instantiate() else {
                return
            }
            vc.rates = viewModel.getRates()
            vc.result = viewModel.quizResult
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        viewModel.currentQuestion += 1

        collectionView.scrollToItem(at: IndexPath(row: viewModel.currentQuestion, section: 0), at: .left, animated: true)
        viewModel.answerSelected = nil
    }
}

extension QuizViewController: StoryboardLoadable {
    static var storyboardName: String = "Quiz"
}

extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.questionsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionCollectionViewCell.reuseIdentifier, for: indexPath) as? QuestionCollectionViewCell else {
            return UICollectionViewCell()
        }
        if viewModel.getQuestionFor(indexPath: indexPath)?.image.url?.isEmpty ?? false {
            cell.hideImageView()
            cell.activityView.isHidden = true
        }

        cell.activityView.isHidden = false
        viewModel.loadAndStorePhoto(for: indexPath) { (image) in
            cell.activityView.isHidden = true
            cell.questionImageView.image = image
        }
        cell.delegate = self
        cell.answersData = viewModel.getQuestionFor(indexPath: indexPath)?.answers ?? []
        cell.answerType = viewModel.getQuestionFor(indexPath: indexPath)?.answer ?? ""
        cell.questionLabel.text = viewModel.getQuestionFor(indexPath: indexPath)?.text

        return cell
    }
}

extension QuizViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
}

extension QuizViewController: QuestionCollectionViewCellDelegate {
    func isCellAlreadySelected() -> Bool {
        (viewModel.answerSelected != nil) ? true : false
    }

    func selectAnswer(row: Int, completion: (QuizAnswerResult) -> Void) {
        viewModel.answerSelected = row
        viewModel.validateAnswer { (result) in
            switch result {
            case .correct: progressView.drawCorrectAnswer()
            case .incorrect: progressView.drawIncorrectAnswer()
            }
            completion(result)
        }
    }


}
