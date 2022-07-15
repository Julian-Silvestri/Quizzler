//
//  QuizPlayingVC.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-09-08.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class QuizPlayingVC: UIViewController,GADFullScreenContentDelegate {

    @IBOutlet weak var finishIcon: UIImageView!
    @IBOutlet weak var currentNumberQuestion: UILabel!
    @IBOutlet weak var questionLabel: QuestionLabel!
    @IBOutlet weak var answerBtn1: AnswerButtons!
    @IBOutlet weak var answerBtn2: AnswerButtons!
    @IBOutlet weak var answerBtn3: AnswerButtons!
    @IBOutlet weak var answerBtn4: AnswerButtons!
    @IBOutlet weak var submitAnswerBtn: SubmitAnswerButton!
    @IBOutlet weak var gameOverView: UIView!
    @IBOutlet weak var finalScore: UILabel!

    @IBOutlet weak var playAgaintBtn: PlayAgainBtn!
    
    let group = DispatchGroup()
    var allAnswers = [NSAttributedString]()
    var answerButtonArray = [AnswerButtons]()
    var currentQuizQuestion = 0
//    var currentQuizQuestion = Quiz.quiz.count-1
    var currentQuizQuestion_notCompuSci = 1
//    var selectedAnswer = NSAttributedString()
    var selectedAnswer = String()
    var scoreForQuiz = 0
    var correct = ""
    var incorrectOne = ""
    var incorrectTwo = ""
    var incorrectThree = ""
    var myAttrString = NSAttributedString()
    
    let strokeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor : UIColor.white
    ]
    
    private var interstitial: GADInterstitialAd?
    
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
//        action(#selector(quit()))
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
            let myAttribute = [ NSAttributedString.Key.strokeColor: UIColor.white , NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 33)!]
            let myAttrString = NSAttributedString(string: string, attributes: myAttribute)
            self.questionLabel.attributedText = myAttrString

            self.questionLabel.setupLabel()
            print(myAttrString)
        }
    }
    
    //MARK: WORKING CODE
//    func decodeQuestionText(str: String){

//        if let data = str.data(using: .utf8) {
//            do {
//                let attrStr = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
//
//
//                self.questionLabel.attributedText = attrStr
//
//                self.questionLabel.setupLabel()
//                print(attrStr)
//            } catch {
//                print(error)
//            }
//        }
//    }
//
//    func decodeAnswerText(str: String, buttonToSet: UIButton, completionHandler: @escaping(Bool?)->Void){
//
//        if let data = str.data(using: .utf8) {
//            do {
//                let attrStr = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
//                buttonToSet.setAttributedTitle(attrStr, for: .normal)
//                print(attrStr)
//                completionHandler(true)
//            } catch {
//                print(error)
//                completionHandler(false)
//            }
//        }
//    }

    func quizStartSetup(){
        self.allAnswers.removeAll()
        self.submitAnswerBtn.disableBtn()
        self.currentNumberQuestion.text = "\(currentQuizQuestion_notCompuSci)/20"
        //sets the question label while decoding the string
        self.decodeQuestionText(input: Quiz.quizzes[currentQuizQuestion].question)
        loadAnswersPerQuestion(correctAnswer: Quiz.quizzes[currentQuizQuestion].correctAnswer, incorrectAnswers: Quiz.quizzes[currentQuizQuestion].incorrectAnswers)
//        randomizeLocationOfAnswer()
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
            self.selectedAnswer = sender.titleLabel?.text ?? "Error"
//            self.selectedAnswer = sender.attributedTitle(for: .normal) ?? NSAttributedString()
            print("self.selectedAnswer ****** => \(self.selectedAnswer)")
            self.submitAnswerBtn.enableBtn()
        }

    }
    
    
    @IBAction func submitFinalAnswer(_ sender: UIButton){
        
//        let attributedCorrectAnswer = decode(str: Quiz.quizzes[currentQuizQuestion].correctAnswer)
        let attributedCorrectAnswer = Quiz.quizzes[currentQuizQuestion].correctAnswer
        print("*************CORRECT ANSWER IS -> \(attributedCorrectAnswer)")
        print("*************SELECTED ANSWER IS -> \(self.selectedAnswer)")
        
//        if self.selectedAnswer == attributedCorrectAnswer {
//            print("correct")
//        } else {
//            print("wrong")
//            print("???????????before????????????? \(self.selectedAnswer)")
//            self.selectedAnswer
//            = attributedCorrectAnswer
//            
//            print("???????????after????????????? \(self.selectedAnswer)")
//        }
        
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
            print("SELECTED \(self.selectedAnswer)")
            print("CORRECT \(Quiz.quizzes[currentQuizQuestion].correctAnswer)")
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
        print("SELF.CURRENTQUIZQUESTION \(self.currentQuizQuestion)")
        if self.currentQuizQuestion > 19 {
            gameOver()
        } else {

            self.submitAnswerBtn.disableBtn()
            for buttons in self.answerButtonArray{
                buttons.deSelected()
            }
            self.currentNumberQuestion.text = "\(currentQuizQuestion_notCompuSci)/20"
            //sets the question label while decoding the string
            

            self.decodeQuestionText(input: Quiz.quizzes[currentQuizQuestion].question)
            loadAnswersPerQuestion(correctAnswer: Quiz.quizzes[currentQuizQuestion].correctAnswer, incorrectAnswers: Quiz.quizzes[currentQuizQuestion].incorrectAnswers)
            
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
    
    func loadAnswersPerQuestion(correctAnswer: String, incorrectAnswers: [String]){
        //decode all strings
        
        
        if self.allAnswers.count >= 1 {
            self.allAnswers.removeAll()

        }
        
        self.allAnswers = [decode(str: correctAnswer)]
        for values in incorrectAnswers {
            self.allAnswers.append(decode(str: values))
        }
        
        print(self.allAnswers)
        print(self.allAnswers.count)
        randomizeLocationOfAnswer()

    }
    
    func randomizeLocationOfAnswer(){
        DispatchQueue.main.async {
            let myAttribute = [ NSAttributedString.Key.strokeColor: UIColor.white , NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 22)!]
    //        myAttrString = NSAttributedString(string: allAnswers.randomElement()!.string, attributes: myAttribute)
            
            var newAnswer = NSAttributedString(string: self.allAnswers.randomElement()!.string, attributes: myAttribute)
//            print("ANswert FOUR -> \(newAnswer)")
            self.answerBtn4.setAttributedTitle(newAnswer, for: .normal)
            
            self.allAnswers.removeAll(where: {$0.string == newAnswer.string})
//            print("Answered removed -> \(newAnswer)")
////******************************
            newAnswer = NSAttributedString(string: self.allAnswers.randomElement()!.string, attributes: myAttribute)
            
//            print("ANSWER THREE  -> \(newAnswer)")
            self.answerBtn3.setAttributedTitle(newAnswer, for: .normal)
            
//            print("answer removed -> \(newAnswer)")

            self.allAnswers.removeAll(where: {$0.string == newAnswer.string})
////******************************
            newAnswer = NSAttributedString(string: self.allAnswers.randomElement()!.string, attributes: myAttribute)
//            print("Answer 2 -> \(newAnswer)")
            self.answerBtn2.setAttributedTitle(newAnswer, for: .normal)
//            print("ANSWER REMOVED -> \(newAnswer)")

            self.allAnswers.removeAll(where: {$0.string == newAnswer.string})
        ///******************************
            newAnswer = NSAttributedString(string: self.allAnswers.randomElement()!.string, attributes: myAttribute)
//            print("Answer One -> \(newAnswer)")
            
            self.answerBtn1.setAttributedTitle(newAnswer, for: .normal)
            
            self.answerBtn4.setupButtons()
            self.answerBtn3.setupButtons()
            self.answerBtn2.setupButtons()
            self.answerBtn1.setupButtons()
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
//
//extension String {
//
//
//    var utfData: Data? {
//        return self.data(using: .utf8)
//    }
//
//    var htmlAttributedString: NSAttributedString? {
//        guard let data = self.utfData else {
//            return nil
//        }
//        do {
//            return try NSAttributedString(data: data,
//           options: [
//                    .documentType: NSAttributedString.DocumentType.html,
//                    .characterEncoding: String.Encoding.utf8.rawValue
//                    ], documentAttributes: strokeTextAttributes)
//        } catch {
//            print(error.localizedDescription)
//            return nil
//        }
//    }
//}
