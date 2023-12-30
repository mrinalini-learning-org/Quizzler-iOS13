//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
   var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func answerButtonClicked(_ sender: UIButton) {
        let userAnswer = sender.currentTitle
        
        let checkedAnswer = quizBrain.checkAnswer(userAnswer: userAnswer!)
        if (checkedAnswer) {
            updateUIButtonColor(sender, UIColor.green)
            progressBar.progress = quizBrain.getQuestionCompletionStatus()
            updateUI()
        } else {
            updateUIButtonColor(sender, UIColor.red)
        }
        
        if (quizBrain.isEndOfQuestions()) {
            resetGame()
        }
        
    }
    
    func updateUIButtonColor(_ sender: UIButton, _ color: UIColor) {
        sender.backgroundColor = color
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            sender.backgroundColor = UIColor.clear
        }
    }
    
    func updateUI() {
        if (quizBrain.questionWithingIndex()) {
            questionLabel.text = quizBrain.getQuestion()
        }
    }
    
    func resetGame() {
        quizBrain.questionNumber = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.progressBar.progress = 0.0
            self.updateUI()
        }
        
    }
    
}

