//
//  QuizPlayingTrueFalseVC.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-06-18.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class QuizPlayingTrueFalseVC: UIViewController, GADFullScreenContentDelegate {
    
    @IBOutlet weak var finishIcon: UIImageView!
    @IBOutlet weak var finalScore: UILabel!
    @IBOutlet weak var quitBtn: UIButton!
    @IBOutlet weak var gameOverView: UIView!
    @IBOutlet weak var currentNumberQuestion: QuizPlayingNumber!
    @IBOutlet weak var submitAnswerBtn: SubmitAnswerButton!
    @IBOutlet weak var answerBtn1: AnswerButtons!
    @IBOutlet weak var answerBtn2: AnswerButtons!
    @IBOutlet weak var questionLabel: QuestionLabel!
    

    let group = DispatchGroup()
    var answerButtonArray = [AnswerButtons]()
    var currentQuizQuestion = 0
//    var currentQuizQuestion = Quiz.quiz.count-1
    var currentQuizQuestion_notCompuSci = 1
    var selectedAnswer: String = ""
    var scoreForQuiz = 0
    var correct = ""
    var incorrectOne = ""
    var incorrectTwo = ""
    var incorrectThree = ""
    
    let strokeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor : UIColor.white
    ]
    
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quizStartSetup()
        self.questionLabel.numberOfLines = 0
        self.answerBtn1.tag = 1
        self.answerBtn2.tag = 2

        self.answerButtonArray = [self.answerBtn1,self.answerBtn2]
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-2779669386425011~4429736348",
                                    request: request,
                          completionHandler: { [self] ad, error in
                            if let error = error {
                              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                              return
                            }
                            interstitial = ad
                            interstitial?.fullScreenContentDelegate = self
                          }
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Quiz.quizzes.removeAll()
        Quiz.quiz.removeAll()
    }
    
    func decodeQuestionText(input: String?) {

        let data = (input?.data(using: String.Encoding.unicode, allowLossyConversion: true))!


        if let string = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil).string {
            //Set color and font
            let myAttribute = [ NSAttributedString.Key.strokeColor: UIColor.white , NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 37)!  ]
            let myAttrString = NSAttributedString(string: string, attributes: myAttribute)
            self.questionLabel.attributedText = myAttrString

            self.questionLabel.setupLabel()
            print(myAttrString)
        }
    }

    func quizStartSetup(){
        self.submitAnswerBtn.disableBtn()
        self.currentNumberQuestion.text = "\(currentQuizQuestion_notCompuSci)/20"
        //sets the question label while decoding the string
        self.decodeQuestionText(input: Quiz.quizzes[currentQuizQuestion].question)
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
            self.selectedAnswer = "\(sender.titleLabel!.text ?? "ERROR")"
            self.submitAnswerBtn.enableBtn()
        }

    }
    
    @IBAction func submitFinalAnswer(_ sender: UIButton){
        
        let attributedCorrectAnswer = Quiz.quizzes[currentQuizQuestion].correctAnswer
       
        
        if self.selectedAnswer == attributedCorrectAnswer {
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
                    self.currentQuizQuestion += 1
                    self.currentQuizQuestion_notCompuSci += 1
                    self.nextQuizQuestion()
                }
            })

        }
    }
    
    func nextQuizQuestion(){

        if self.currentQuizQuestion > 19 {
            gameOver()
        }else{
            self.submitAnswerBtn.disableBtn()
            for buttons in self.answerButtonArray{
                buttons.deSelected()
            }
            self.currentNumberQuestion.text = "\(currentQuizQuestion_notCompuSci)/20"

            //sets the question label while decoding the string
            print("CURRENT QUIZ QUESTION -> \(currentQuizQuestion)")
            if currentQuizQuestion > 19 {
                gameOver()
            }else{
                self.decodeQuestionText(input: Quiz.quizzes[currentQuizQuestion].question)
                randomizeLocationOfAnswer(correctAnswer: Quiz.quizzes[currentQuizQuestion].correctAnswer, incorrectAnswers: Quiz.quizzes[currentQuizQuestion].incorrectAnswers)
            }
        }
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
    func gameOver(){
        self.finalScore.text = "\(self.scoreForQuiz) / 20"
        if self.scoreForQuiz >= 14 {
            self.finishIcon.image = UIImage(named: "happyFace")
        } else if self.scoreForQuiz < 14 && self.scoreForQuiz >= 10{
            self.finishIcon.image = UIImage(named: "neutralFace")
        } else {
            self.finishIcon.image = UIImage(named: "sadFace")
        }
        UIView.animate(withDuration: 1.5, animations: {
            self.gameOverView.alpha = 1
            self.finalScore.alpha = 1
        })
    }

    @IBAction func playAgainBtn(_ sender: Any) {
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
        
        self.answerBtn1.setTitle("True", for: .normal)
        self.answerBtn2.setTitle("False", for: .normal)
        
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
    
    //MARK: Google Ads
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
    print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    print("Ad did dismiss full screen content.")
    }


}
