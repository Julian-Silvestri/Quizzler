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
    var answerButtonArray = [AnswerButtons]()
    var currentQuizQuestion = 0
    var currentQuizQuestion_notCompuSci = 1
    var selectedAnswer = ""
    var scoreForQuiz = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quizStartSetup()
        self.questionLabel.textColor = UIColor.white
        self.questionLabel.font = UIFont(name: "Avenir", size: 16)
        self.questionLabel.numberOfLines = 0
        
        self.answerBtn1.tag = 1
        self.answerBtn2.tag = 2
        self.answerBtn3.tag = 3
        self.answerBtn4.tag = 4
        self.answerButtonArray = [self.answerBtn1,self.answerBtn2,self.answerBtn3,self.answerBtn4]
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

    func quizStartSetup(){
        self.submitAnswerBtn.disableBtn()
        self.currentNumberQuestion.text = "\(currentQuizQuestion_notCompuSci)/20"
        //sets the question label while decoding the string
        self.decode(str: self.quiz[currentQuizQuestion].question)
        randomizeLocationOfAnswer(correctAnswer: self.quiz[currentQuizQuestion].correctAnswer, incorrectAnswers: self.quiz[currentQuizQuestion].incorrectAnswers)
    
    }
    
    @IBAction func answerSelectedAction(_ sender: AnswerButtons){
        
        for buttons in self.answerButtonArray {
            if buttons.backgroundColor == sender.selectedColor{
                buttons.backgroundColor = sender.deSelectedColor
            }
        }
        
        if sender.backgroundColor == sender.selectedColor {
            sender.deSelected()
        } else {
            sender.selected()
            self.selectedAnswer = sender.title(for: .normal) ?? ""
            self.submitAnswerBtn.enableBtn()
        }
    }
    
    @IBAction func submitAnswerAction(_ sender: Any) {
        alertActionYesNo(viewController: self, title: "Confirm", message: "Is that your final answer?", completionHandler: {yesNo in
            if yesNo == true {
                self.determineIfRightOrWrong(selectedAnswer: self.selectedAnswer)
            }
        })
    }
    
    func determineIfRightOrWrong(selectedAnswer: String){
        if selectedAnswer == self.quiz[currentQuizQuestion].correctAnswer {
            alertActionYesNoWithImage(viewController: self, title: "Correct!", message: "Good Job", image: UIImage(named: "correctIcon")!, completionHandler: {success in
                if success == true {
                    //next question + 1 to score
                    self.scoreForQuiz += 1
                    self.currentQuizQuestion += 1
                    self.currentQuizQuestion_notCompuSci += 1
                    self.nextQuizQuestion()
                }
            })

        } else {
            alertActionYesNoWithImage(viewController: self, title: "Wrong!", message: "Sorry..", image: UIImage(named: "wrongIcon")!, completionHandler: {success in
                if success == true {
                    //next question + 0 to score
                    
                    self.scoreForQuiz += 0
                    self.currentQuizQuestion += 1
                    self.currentQuizQuestion_notCompuSci += 1
                    self.nextQuizQuestion()
                }
            })

        }
    }
    
    func nextQuizQuestion(){
        self.submitAnswerBtn.disableBtn()
        self.questionLabel.textColor = UIColor.white
        for buttons in self.answerButtonArray{
            buttons.deSelected()
        }
        self.currentNumberQuestion.text = "\(currentQuizQuestion_notCompuSci)/20"
        //sets the question label while decoding the string
        self.decode(str: self.quiz[currentQuizQuestion].question)
        randomizeLocationOfAnswer(correctAnswer: self.quiz[currentQuizQuestion].correctAnswer, incorrectAnswers: self.quiz[currentQuizQuestion].incorrectAnswers)
    }
    
    
    @IBAction func quitBtn(_ sender: Any) {
        alertActionYesNo(viewController: self, title: "Quit?", message: "Are you sure you want to quit? All progress will be lost.", completionHandler: {yesNo in
            if yesNo == true {
                self.dismiss(animated: true, completion: nil)
            } else {
                return
            }
        })
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
        
        DispatchQueue.main.async {
            print("THIS IS ALL ANSWERS \(allAnswers)")
            self.answerBtn4.setTitle(allAnswers.randomElement(), for: .normal)
            allAnswers.removeAll(where: {$0 == self.answerBtn4.title(for: .normal) ?? ""})
            print("THIS IS ALL ANSWERS \(allAnswers)")
            self.answerBtn3.setTitle(allAnswers.randomElement(), for: .normal)
            allAnswers.removeAll(where: {$0 == self.answerBtn3.title(for: .normal) ?? ""})
            print("THIS IS ALL ANSWERS \(allAnswers)")
            self.answerBtn2.setTitle(allAnswers.randomElement(), for: .normal)
            allAnswers.removeAll(where: {$0 == self.answerBtn2.title(for: .normal) ?? ""})
            print("THIS IS ALL ANSWERS \(allAnswers)")
            self.answerBtn1.setTitle(allAnswers.randomElement(), for: .normal)
        }
        
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
