//
//  QuizPlayingVC.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-09-08.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit
import AVFoundation

class QuizPlayingVC: UIViewController {
    
    @IBOutlet weak var currentNumberQuestion: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerBtn1: AnswerButtons!
    @IBOutlet weak var answerBtn2: AnswerButtons!
    @IBOutlet weak var answerBtn3: AnswerButtons!
    @IBOutlet weak var answerBtn4: AnswerButtons!
    @IBOutlet weak var submitAnswerBtn: SubmitAnswerButton!
    
    var quiz = Quiz.quizzes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quizSetup()
        self.questionLabel.textColor = UIColor.white
        self.questionLabel.font = UIFont(name: "Avenir", size: 16)
        self.questionLabel.numberOfLines = 0
        self.submitAnswerBtn.disableBtn()
//        self.questionLabel.minimumScaleFactor =
    }
    
    func decode(str: String){
        
        if let data = str.data(using: .utf8) {
            do {
                let attrStr = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                self.questionLabel.attributedText = attrStr
                print(attrStr)
            } catch {
                print(error)
            }
        }
    }

    func quizSetup(){
        self.currentNumberQuestion.text = "1/20"
        self.decode(str: quiz[0].question)
        self.answerBtn1.setTitle(quiz[0].incorrectAnswers[0], for: .normal)
        self.answerBtn2.setTitle(quiz[0].incorrectAnswers[1], for: .normal)
        self.answerBtn3.setTitle(quiz[0].incorrectAnswers[2], for: .normal)
        self.answerBtn4.setTitle(quiz[0].correctAnswer, for: .normal)
    }
    
    @IBAction func answerBtn1Action(_ sender: Any) {
    }
    
    @IBAction func answerBtn2Action(_ sender: Any) {
    }
    
    @IBAction func answerBtn3Action(_ sender: Any) {
    }
    
    @IBAction func answerBtn4Action(_ sender: Any) {
    }
    
    @IBAction func quitBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func test(_ sender: Any) {
        
//        let utterance = AVSpeechUtterance(string: "")
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//
//        let synth = AVSpeechSynthesizer()
//        synth.speak(utterance)

    }
    
    func randomizeLocationOfAnswer(correctAnswer: String, incorrectAnswers: [String]){
        
        var allAnswers = [correctAnswer]
        for values in incorrectAnswers {
            allAnswers.append(values)
        }
        
        self.answerBtn4.setTitle(allAnswers.randomElement(), for: .normal)
        
        allAnswers.removeAll(where: {$0 == self.answerBtn4.titleLabel?.text ?? ""})
        
        self.answerBtn3.setTitle(allAnswers.randomElement(), for: .normal)
        
        allAnswers.removeAll(where: {$0 == self.answerBtn3.titleLabel?.text ?? ""})
        
        self.answerBtn2.setTitle(allAnswers.randomElement(), for: .normal)
        
        allAnswers.removeAll(where: {$0 == self.answerBtn2.titleLabel?.text ?? ""})
        
        self.answerBtn1.setTitle(allAnswers.randomElement(), for: .normal)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            // Fallback on earlier versions
            return .darkContent
            
        }
    }
    
}
