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
    
    private var game = Game()
    
    @IBAction func onTapButton(_ sender: Any) {
        startNewGame()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = Notification.Name(rawValue: "QuestionsLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(questionLoaded), name: name, object: nil)
        
        startNewGame()
    }
    
    @objc private func questionLoaded() {
        activityManager.isHidden = true
        newGameButton.isHidden = false
        questionView.title = game.currentQuestion.title
    }

    private func startNewGame() {
        newGameButton.isHidden = true
        questionView.title = "Loading ..."
        activityManager.isHidden = false
        questionView.style = .standard
        scoreLabel.text = "0 / 10";
        
        game.refresh()
    }

}

