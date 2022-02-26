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
    @IBOutlet weak var questionLabel: QuestionLabel!
    @IBOutlet weak var answerBtn1: AnswerButtons!
    @IBOutlet weak var answerBtn2: AnswerButtons!
    @IBOutlet weak var answerBtn3: AnswerButtons!
    @IBOutlet weak var answerBtn4: AnswerButtons!
    @IBOutlet weak var submitAnswerBtn: SubmitAnswerButton!
    
    let group = DispatchGroup()
    
//    var quiz = Quiz.quizzes
    var answerButtonArray = [AnswerButtons]()
    var currentQuizQuestion = 0
    var currentQuizQuestion_notCompuSci = 1
    var selectedAnswer = ""
    var scoreForQuiz = 0
    
    var correct = ""
    var incorrectOne = ""
    var incorrectTwo = ""
    var incorrectThree = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quizStartSetup()
//        self.questionLabel.textColor = UIColor.white
//        self.questionLabel.font = UIFont(name: "Avenir", size: 16)
        self.questionLabel.numberOfLines = 0
        self.answerBtn1.tag = 1
        self.answerBtn2.tag = 2
        self.answerBtn3.tag = 3
        self.answerBtn4.tag = 4
        self.answerButtonArray = [self.answerBtn1,self.answerBtn2,self.answerBtn3,self.answerBtn4]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Quiz.quizzes.removeAll()
        Quiz.quiz.removeAll()
    }
    
    func decodeQuestionText(str: String){
        
        if let data = str.data(using: .utf8) {
            do {
                let attrStr = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                self.questionLabel.attributedText = attrStr
                self.questionLabel.setupLabel()
                print(attrStr)
            } catch {
                print(error)
            }
        }
    }
    
    func decodeAnswerText(str: String, buttonToSet: UIButton, completionHandler: @escaping(Bool?)->Void){
        
        if let data = str.data(using: .utf8) {
            do {
                let attrStr = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                buttonToSet.setAttributedTitle(attrStr, for: .normal)
                print(attrStr)
                completionHandler(true)
            } catch {
                print(error)
                completionHandler(false)
            }
        }
    }

    func quizStartSetup(){
        self.submitAnswerBtn.disableBtn()
        self.currentNumberQuestion.text = "\(currentQuizQuestion_notCompuSci)/20"
        //sets the question label while decoding the string
        self.decodeQuestionText(str: Quiz.quizzes[currentQuizQuestion].question)
        randomizeLocationOfAnswer(correctAnswer: Quiz.quizzes[currentQuizQuestion].correctAnswer, incorrectAnswers: Quiz.quizzes[currentQuizQuestion].incorrectAnswers)
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
        if selectedAnswer == Quiz.quizzes[currentQuizQuestion].correctAnswer {
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
            alertActionYesNoWithImage(viewController: self, title: "Wrong!", message: "Correct answer was \(Quiz.quizzes[currentQuizQuestion].correctAnswer).", image: UIImage(named: "wrongIcon")!, completionHandler: {success in
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
        self.decodeQuestionText(str: Quiz.quizzes[currentQuizQuestion].question)
        randomizeLocationOfAnswer(correctAnswer: Quiz.quizzes[currentQuizQuestion].correctAnswer, incorrectAnswers: Quiz.quizzes[currentQuizQuestion].incorrectAnswers)
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
        

        self.group.enter()
        
        self.decodeAnswerText(str: allAnswers.randomElement() ?? "", buttonToSet: self.answerBtn4, completionHandler: {_ in
            self.group.leave()
        })
        
        allAnswers.removeAll(where: {$0 == self.answerBtn4.title(for: .normal) ?? ""})
        
        self.group.enter()
        
        self.decodeAnswerText(str: allAnswers.randomElement() ?? "", buttonToSet: self.answerBtn3, completionHandler: {_ in
            self.group.leave()
        })
        
        allAnswers.removeAll(where: {$0 == self.answerBtn3.title(for: .normal) ?? ""})
        
        self.group.enter()
        
        self.decodeAnswerText(str: allAnswers.randomElement() ?? "", buttonToSet: self.answerBtn2, completionHandler: {_ in
            self.group.leave()
        })
        
        allAnswers.removeAll(where: {$0 == self.answerBtn2.title(for: .normal) ?? ""})
        
        self.group.enter()
        
        self.decodeAnswerText(str: allAnswers.randomElement() ?? "", buttonToSet: self.answerBtn1, completionHandler: {_ in
            self.group.leave()
        })

        self.answerBtn4.setupButtons()
        self.answerBtn3.setupButtons()
        self.answerBtn2.setupButtons()
        self.answerBtn1.setupButtons()

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
