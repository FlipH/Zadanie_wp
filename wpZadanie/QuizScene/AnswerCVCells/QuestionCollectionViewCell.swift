//
//  CollectionViewCell.swift
//  wpZadanie
//
//  Created by Filip Harasim on 03/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

protocol QuestionCollectionViewCellDelegate: class {
    func selectAnswer(row: Int, completion: (QuizAnswerResult) -> Void)
    func isCellAlreadySelected() -> Bool
}


class QuestionCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "QuestionCollectionViewCellReuseIdentifier"

    var answerType: String = ""
    var answersData: [QuizAnswer] = [] {
        didSet {
            answersCollectionView.reloadData()
        }
    }

    weak var delegate: QuestionCollectionViewCellDelegate?

    let questionImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()

    let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()

    let separator: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "separator")
        return v
    }()

    let answersCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(named: "background")
        cv.isScrollEnabled = false

        return cv
    }()

    let activityView: ActivityIndicatorView = {
        let av = ActivityIndicatorView(frame: .zero)
        return av
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraints()
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self

        answersCollectionView.register(UINib.init(nibName: "TextAnswerCVCell", bundle: nil), forCellWithReuseIdentifier: "TextAnswerCVCell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func hideImageView() {
        imageHeightConstraint.isActive = false
    }

    var imageHeightConstraint: NSLayoutConstraint!
    var activityIndConstraint: NSLayoutConstraint!

    private func setupConstraints() {

        self.addSubview(answersCollectionView)
        self.addSubview(questionLabel)
        self.addSubview(questionImageView)
        self.addSubview(separator)
        self.addSubview(activityView)

        self.questionImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32).isActive = true
        self.questionImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32).isActive = true
        imageHeightConstraint = self.questionImageView.heightAnchor.constraint(equalToConstant: 230)
        imageHeightConstraint.isActive = true
        self.questionImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true

        self.activityView.leadingAnchor.constraint(equalTo: self.questionImageView.leadingAnchor).isActive = true
        self.activityView.trailingAnchor.constraint(equalTo: self.questionImageView.trailingAnchor).isActive = true
        self.activityView.topAnchor.constraint(equalTo: self.questionImageView.topAnchor).isActive = true
        self.activityView.bottomAnchor.constraint(equalTo: self.questionImageView.bottomAnchor).isActive = true


        self.questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.questionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.questionLabel.topAnchor.constraint(equalTo: questionImageView.bottomAnchor, constant: 16).isActive = true
        let constraintTopQuestionLabel: NSLayoutConstraint = self.questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        constraintTopQuestionLabel.priority = UILayoutPriority(rawValue: 250)
        constraintTopQuestionLabel.isActive = true
        self.questionLabel.heightAnchor.constraint(equalToConstant: 160).isActive = true

        self.separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.separator.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8).isActive = true
        self.separator.heightAnchor.constraint(equalToConstant: 1).isActive = true

        self.answersCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.answersCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        self.answersCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        self.answersCollectionView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16).isActive = true
    }
}

//MARK: - CollectionViewDataSource, CollectionViewDelegate, DelegateFlowLayout
extension QuestionCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answersData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextAnswerCVCell", for: indexPath) as? TextAnswerCVCell else {
            return UICollectionViewCell()
        }
        cell.answerLabel?.text = answersData[indexPath.row].text
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cell = collectionView.cellForItem(at: indexPath) as? TextAnswerCVCell, !(delegate?.isCellAlreadySelected() ?? false) else {
            return
        }
        delegate?.selectAnswer(row: indexPath.row) { result in
            switch result {
            case .correct:
                cell.setupCellForResult(type: .correct)
            case .incorrect:
                cell.setupCellForResult(type: .incorrect)
                break
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      //TODO: Fix magic values
        let totalSpacing: CGFloat = CGFloat((answersData.count - 1) * 10)
        let height: CGFloat = (answersCollectionView.bounds.height - totalSpacing) / CGFloat(answersData.count)
        return CGSize(width: answersCollectionView.bounds.width, height: height)
    }
}


