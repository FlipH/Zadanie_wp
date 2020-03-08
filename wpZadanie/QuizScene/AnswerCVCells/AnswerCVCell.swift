//
//  AnswerCVCell.swift
//  wpZadanie
//
//  Created by Filip Harasim on 04/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

class TextAnswerCVCell: UICollectionViewCell {

    @IBOutlet weak var answerLabel: UILabel!

    func setupCellForResult(type: QuizAnswerResult) {
        switch type {
        case .correct:
            self.backgroundColor = UIColor(named: "correctAnswer")
        case .incorrect:
            self.backgroundColor = UIColor(named: "incorrectAnswer")
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layer.borderWidth = 1
        layer.cornerRadius = 18
        layer.borderColor = UIColor.black.cgColor
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
        isHighlighted = false
        self.backgroundColor = UIColor(named: "answersCellBackground")
    }
}

class ImageAnswerCvCell: UICollectionViewCell {

    @IBOutlet weak var answerImageV: UIImageView!
}
