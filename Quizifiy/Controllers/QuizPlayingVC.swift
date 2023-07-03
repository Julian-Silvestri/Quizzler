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
    /// used to keep track of the players answers
    var playerAnswers = [String]()
    ///used as the current questions answers, the next question will refresh these answers to match the current question
    var allAnswers = [NSAttributedString]()
    ///used to keep track of the answer buttons in an array to track answers selected
    var answerButtonArray = [AnswerButtons]()
    ///used as the the array counter to grab the next quiz
    var currentQuizQuestion = 0
    ///used as the title label current question 1/20
    var currentQuizQuestion_notCompuSci = 1
    ///used as the players selected answer for the question
    var selectedAnswer = String()
    ///used as the players current score
    var scoreForQuiz = 0
    //
    var type: String? = "multiple"
    
    var correct = ""
    var incorrectOne = ""
    var incorrectTwo = ""
    var incorrectThree = ""
    var myAttrString = NSAttributedString()
    var showAd = 1 // tracks the number of ads to be shown. Shows ad on, 5, 10, 15 and on game over
    
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
        self.answerBtn3.tag = 3
        self.answerBtn4.tag = 4
        self.answerButtonArray = [self.answerBtn1,self.answerBtn2,self.answerBtn3,self.answerBtn4]
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-2779669386425011/9512588350",
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
    }
    
    //MARK: NSAttributed Decoder
    func decodeQuestionText(input: String?) {

        let data = (input?.data(using: String.Encoding.unicode, allowLossyConversion: true))!


        if let string = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil).string {
            //Set color and font
            let myAttribute = [ NSAttributedString.Key.strokeColor: UIColor.white , NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 33)!]
            let myAttrString = NSAttributedString(string: string, attributes: myAttribute)
            self.questionLabel.attributedText = myAttrString

            self.questionLabel.setupLabel()
//            print(myAttrString)
        }
    }
    
    //MARK: Quiz setup
    //first load setup
    func quizStartSetup(){
        if self.type == "boolean"{
            self.currentNumberQuestion.text = "\(currentQuizQuestion_notCompuSci)/10"
        } else {
            self.currentNumberQuestion.text = "\(currentQuizQuestion_notCompuSci)/20"
        }
        self.allAnswers.removeAll()
        self.submitAnswerBtn.disableBtn()
        
        //sets the question label while decoding the string
        self.decodeQuestionText(input: Quiz.quizzes[currentQuizQuestion].question)
        loadAnswersPerQuestion(correctAnswer: Quiz.quizzes[currentQuizQuestion].correctAnswer, incorrectAnswers: Quiz.quizzes[currentQuizQuestion].incorrectAnswers)
//        randomizeLocationOfAnswer()
    }
    
    //MARK: Answer Selected
    //This function coordinates the colors between
    //the answer buttons to indicate which answer has been selected
    //to the user visually.
    //IE: Tap answer 1: background blue, all other answers background red
    //    Tap answer 2: background blue, all other answers background red
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
//            print("self.selectedAnswer ****** => \(self.selectedAnswer)")
            self.submitAnswerBtn.enableBtn()
        }

    }
    //MARK: Submit Final Question
    //This function will take the users inputted final answer
    //and determine if it is correct or incorrect.
    //It displays an alert to the user with the result.
    //This function also tracks the ad requests.
    @IBAction func submitFinalAnswer(_ sender: UIButton){
        print("************\(currentQuizQuestion)*************")
        
        let attributedCorrectAnswer = Quiz.quizzes[currentQuizQuestion].correctAnswer
        print("*************CORRECT ANSWER IS -> \(decode(str:attributedCorrectAnswer).string)")
        print("*************SELECTED ANSWER IS -> \(self.selectedAnswer)")
        
        ///append players final answer to array
        self.playerAnswers.append(self.selectedAnswer)

        if self.selectedAnswer == decode(str:attributedCorrectAnswer).string {
        
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
//            print("SELECTED \(self.selectedAnswer)")
//            print("CORRECT \(Quiz.quizzes[currentQuizQuestion].correctAnswer)")
            alertActionYesNoWithImage(viewController: self, title: "Wrong!", message: "Correct answer was \(decode(str:Quiz.quizzes[currentQuizQuestion].correctAnswer).string).", image: UIImage(named: "wrongIcon")!, completionHandler: {success in
                if success == true {
                    //next question + 0 to score
                    self.currentQuizQuestion += 1
                    self.currentQuizQuestion_notCompuSci += 1
                    self.nextQuizQuestion()
                }
            })

        }
    }
    
    //MARK: NEXT QUESTION
    //this function will determine if the user has reached the end of the quiz
    //if the user has not reached the end of the quiz, this function will display
    //the next question. It will also randomize the location of the answer.
    func nextQuizQuestion(){
    
//        print("SELF.CURRENTQUIZQUESTION \(self.currentQuizQuestion)")
        
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
            
            //MARK: AD REQUEST
            if showAd == 5 || showAd == 10 || showAd == 15 {
                loadAdRequest()
//                if GAMInterstitialAd.is
                
                if interstitial != nil {
                    interstitial?.present(fromRootViewController: self)

                } else {
                  print("Ad wasn't ready")
                }
            }
            showAd += 1
        }

    }
    
    //MARK: Quit 
    @IBAction func quitBtn(_ sender: Any) {
        alertActionYesNo(viewController: self, title: "Quit?", message: "Are you sure you want to quit? All progress will be lost.", completionHandler: {yesNo in
            if yesNo == true {
//                NetworkService.secrectKey.removeAll()
//                NetworkService.shared.resetToken(completionHandler: {success in
//                    if success == true {
//                        filterQuizzes(completionHandler: {_ in})
//                    }
//                })
                self.dismiss(animated: true, completion: nil)
            } else {
                return
            }
        })
    
    }


    //MARK: Play Again
    @IBAction func playAgainBtn(_ sender: Any) {
        Quiz.quizzes.removeAll()
        Quiz.quiz.removeAll()
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

        randomizeLocationOfAnswer()

    }
    //MARK: RANDOMIZE ANSWER
    //This function will take the current answer to the multiple choice question
    //and will randomize where it is within the stack of the four buttons
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
    
    func gameOver(){
        
        //set the final score label
        //set the image for the game over screen based on score
        //animate the game over view on top
        //MARK: need to add more to the game over screen. Too bland.
    
        self.finalScore.text = "\(self.scoreForQuiz) / 20"
        //MARK: GAME OVER ICON
//        if self.scoreForQuiz >= 14 {
//            self.finishIcon.image = UIImage(named: "happyFace")
//        } else if self.scoreForQuiz < 14 && self.scoreForQuiz >= 10{
//            self.finishIcon.image = UIImage(named: "neutralFace")
//        } else {
//            self.finishIcon.image = UIImage(named: "sadFace")
//        }
        UIView.animate(withDuration: 1.5, animations: {
            self.gameOverView.alpha = 1
            self.finalScore.alpha = 1
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewResultsMC" {
            if let destination = segue.destination as? ShowResultsOfQuizVC {
                destination.playersScore = self.scoreForQuiz
                destination.playersAnswers = self.playerAnswers
            }
        }
    }
    
    @IBAction func showResultsActionBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "viewResultsMC", sender: self)
    }
    
    //MARK: Google Ads
    
    func loadAdRequest(){
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-2779669386425011/9512588350",
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
        loadAdRequest()
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

