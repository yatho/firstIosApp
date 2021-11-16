//
//  ViewController.swift
//  game
//
//  Created by Yann-thomas Le Moigne on 16/11/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var activityManager: UIActivityIndicatorView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func onTapButton(_ sender: Any) {
        startNewGame()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func startNewGame() {
        newGameButton.isHidden = true
        questionView.title = "Loading ..."
        questionView.style = .standard
        scoreLabel.text = "0 / 10";
    }

}

