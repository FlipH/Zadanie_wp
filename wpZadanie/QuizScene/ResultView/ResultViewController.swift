//
//  ResultViewController.swift
//  wpZadanie
//
//  Created by Filip Harasim on 07/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var rates: [Rate] = []
    var result: Float = 0

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        showResultAndLabels()
    }

    func showResultAndLabels() {
        resultLabel.text = String(format: "%.2f", result) + "%"
        for rate in rates {
            let range = Float(rate.from) ... Float(rate.to)
            if range.contains(result) {
                topLabel.text = rate.content
            }
        }
    }

    @IBAction func endQuiz(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension ResultViewController: StoryboardLoadable {
    static var storyboardName: String = "Result"
}
