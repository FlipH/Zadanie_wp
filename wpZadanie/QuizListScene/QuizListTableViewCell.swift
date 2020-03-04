//
//  QuizListTableViewCell.swift
//  wpZadanie
//
//  Created by Filip Harasim on 01/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

class QuizListTableViewCell: UITableViewCell {

static let reuseIdentifier = "QuizListTableViewCellReuseIdentifier"

    @IBOutlet weak var quizName: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
}
