//
//  QuizViewController.swift
//  wpZadanie
//
//  Created by Filip Harasim on 03/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension QuizViewController: StoryboardLoadable {
    static var storyboardName: String = "Quiz"
}
