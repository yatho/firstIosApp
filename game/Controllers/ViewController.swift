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
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragQuestionView(_:)))
        questionView.addGestureRecognizer(panGestureRecognizer)
        
        startNewGame()
    }
    
    @objc private func dragQuestionView(_ sender: UIPanGestureRecognizer) {
        if game.state == .over {
            return
        }
        switch sender.state {
        case .began, .changed:
            transformQuestionViewWith(gesture: sender)
        case .ended, .cancelled:
            answerQuestion()
        default:
            break
        }
    }
    
    private func transformQuestionViewWith(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: questionView)
        let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
        let translationPercent = translation.x/(UIScreen.main.bounds.width / 2)
        let rotationAngle = (CGFloat.pi / 6) * translationPercent
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        
        let transform = translationTransform.concatenating(rotationTransform)
        questionView.transform = transform
        
        if translation.x < 0 {
            questionView.style = .incorrect
        } else if translation.x > 0 {
            questionView.style = .correct
        } else {
            questionView.style = .standard
        }
    }

    private func answerQuestion() {
        switch questionView.style {
            case .correct:
                game.answerCurrentQuestion(with: true)
            case .incorrect:
                game.answerCurrentQuestion(with: false)
            case .standard:
                break
        }
        
        questionView.transform = .identity
        questionView.style = .standard
        scoreLabel.text = "\(game.score) / 10"
        if game.state == .ongoing {
            questionView.title = game.currentQuestion.title
        } else {
            questionView.title = "Finished"
        }
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

