//
//  CollectionViewCell.swift
//  wpZadanie
//
//  Created by Filip Harasim on 03/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    var answerType: String = ""
    var answersData: [QuizAnswer] = []

    let questionImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()

    let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    let answersCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupConstraints()
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self

        answersCollectionView.register(UINib.init(nibName: "TextAnswerCVCell", bundle: nil), forCellWithReuseIdentifier: "TextAnswerCVCell")
        answersCollectionView.register(UINib.init(nibName: "ImageAnswerCVCell", bundle: nil), forCellWithReuseIdentifier: "ImageAnswerCVCell")

    }

    private func setupConstraints() {

        self.addSubview(answersCollectionView)
        self.addSubview(questionLabel)
        self.addSubview(questionImageView)

        self.questionImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.questionImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.questionImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.questionImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true

        self.questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.questionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8).isActive = true
        self.questionLabel.topAnchor.constraint(equalTo: questionImageView.bottomAnchor, constant: 16).isActive = true

        self.answersCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.answersCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8).isActive = true
        self.answersCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8).isActive = true
        self.answersCollectionView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16).isActive = true

    }
}

//MARK: - CollectionViewDataSource, CollectionViewDelegate, DelegateFlowLayout
extension CollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answersData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch answerType {
        case "ANSWER_IMAGE": break
        case "ANSWER_TEXT":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextAnswerCVCell", for: indexPath) as? TextAnswerCVCell else {
                return UICollectionViewCell()
            }
            cell.numberLabel?.text = "\(answersData[indexPath.row].order)."
            cell.answerLabel?.text = answersData[indexPath.row].text
            return cell
        default:
            return UICollectionViewCell()
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }


}


