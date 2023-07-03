//
//  Dashboard.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-08-22.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class HomeVC: UIViewController {

    @IBOutlet weak var selectQuizTypeBtn: TypeButtonMenu!
    @IBOutlet weak var startQuizBtn: StartQuizButton!
    @IBOutlet weak var selectGenreBtn: GenreButtonMenu!
    @IBOutlet weak var selectDifficultyBtn: DifficultyButtonMenu!
    
    private var interstitial: GADInterstitialAd?
    
    private var stepOne = false
    private var stepTwo = false
    private var stepThree = false
    
    
    var difficulty = ""
    var type = ""
    var quizSetupTimer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dump(QuizCount.totalQuestions)
//        print("****************")
//        dump(QuizCount.quizCount)
//        filterQuizzes()
//        print("************")
//        dump(QuizCount.quizCount)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Quiz.quizzes.removeAll()
        Quiz.quiz.removeAll()
        self.setupBtnsOnLoad()
        filterQuizzes(completionHandler: {_ in})
        self.quizSetupTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(quizSetupProcess), userInfo: nil, repeats: true)

//        NetworkService.secrectKey.removeAll()
//        NetworkService.shared.grabToken(completionHandler: {success in
//            if success == true {
//                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
//                    filterQuizzes(completionHandler: {_ in})
//                })
//            } else {
//                fatalError()
//                
//            }
//        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setupBtnsOnLoad()
        self.quizSetupTimer.invalidate()
    }

    
    //IVE REMOVED THE DIFFICULTY LOGIC , ALL QUIZZES ARE SET TO EASY
    @objc func quizSetupProcess(){
        if self.selectQuizTypeBtn.titleLabel?.text != "Select Quiz Type"  {
            self.selectGenreBtn.enable()
            if selectGenreBtn.titleLabel?.text != "Select Genre"{
//                self.selectDifficultyBtn.enable()
                self.startQuizBtn.enable()
                CustomLoader.instance.hideLoaderView()
//                if self.selectDifficultyBtn.titleLabel?.text != "Select Difficulty"{
//                    self.startQuizBtn.enable()
//                    CustomLoader.instance.hideLoaderView()
//                }
            }
        }
    }
    
    @IBAction func selectTypeBtnAction(_ sender: Any) {
//        quizSetupTrackerFunction()
        
    }
    @IBAction func startQuiz(_ sender: Any) {
        
        //|| self.selectDifficultyBtn.titleLabel?.text == "Select Difficulty"
        if self.selectGenreBtn.titleLabel?.text == "Select Genre" {
            alertActionBasic(viewController: self, title: "Error",  message: "Please make sure you select a genre", completionHandler: {success in
                return
            })
        }else{
//            print("TAG = \(self.selectGenreBtn.tag)")
            difficulty = "easy"
//            if self.selectDifficultyBtn.tag == 1 {
//                difficulty = "easy"
//            } else if self.selectDifficultyBtn.tag == 2 {
//                difficulty = "medium"
//            } else if self.selectDifficultyBtn.tag == 3 {
//                difficulty = "hard"
//            }
            
            ///The purpose of this logic block here is to avoid the scenario where a user taps a quiz to play and the first level (easy) is unavailable.
            ///If the first level (easy) is unavailable, instead of erroring out this logic will attempt another call to grab the second level quiz (medium).
            ///If the second level (medium) is unavailable, instead of erroring out, logic will attempt another call to grab the third level quiz (hard).
            ///If last level (hard) fails, then the app will error out and
            if self.selectQuizTypeBtn.tag == 1{
                type = "boolean"
//                print("BOOOL")
                NetworkService.shared.loadQuiz(type: type, difficulty: difficulty, category: self.selectGenreBtn.tag, completionHandler: { [self]success in
                    if success == true {
//                        print("quiz loaded")
                        dump(Quiz.quizzes)
                        DispatchQueue.main.sync {
                            if Quiz.quizzes.count <= 0 {
                                NetworkService.shared.loadQuiz(type: type, difficulty: "medium", category: self.selectGenreBtn.tag, completionHandler: {success in
                                    if success == true {
                                        print("MOVED ON TO LOAD MEDIUM")
                                        if Quiz.quizzes.count <= 0 {
                                            DispatchQueue.main.async {
                                                NetworkService.shared.loadQuiz(type: self.type, difficulty: "hard", category: self.selectGenreBtn.tag, completionHandler: {success in
                                                    if success == true {
                                                        print("MOVED ON TO HARD")
                                                        if Quiz.quizzes.count <= 0{
                                                            DispatchQueue.main.async {
                                                                alertActionBasic(viewController: self, title: "Error", message: "Could not load this True or False quiz. Please select a different genre or try again later.", completionHandler: {_ in})
                                                            }

                                                        } else {
                                                            self.quizSetupTimer.invalidate()
                                                            DispatchQueue.main.async {
                                                                self.performSegue(withIdentifier: "playTF", sender: self)
                                                            }
                                                            
                                                        }
                                                    }
                                                })
                                            }
  
                                        } else {
                                            self.quizSetupTimer.invalidate()
                                            DispatchQueue.main.async {
                                                self.performSegue(withIdentifier:"playTF", sender: self)
                                            }
                                            
                                        }
                                    }
                                })
                                
                            } else {
                                self.quizSetupTimer.invalidate()
                                self.performSegue(withIdentifier: "playTF", sender: self)
                            }
                        }
                    }
                })
            }else if self.selectQuizTypeBtn.tag == 2 {
                type = "multiple"
//                print("MULTIPLEEEEEE")
                NetworkService.shared.loadQuiz(type: type, difficulty: difficulty, category: self.selectGenreBtn.tag, completionHandler: { [self]success in
                    if success == true {
//                        print("quiz loaded")
                        dump(Quiz.quizzes)
                        DispatchQueue.main.sync {
                            if Quiz.quizzes.count <= 0 {
                                NetworkService.shared.loadQuiz(type: type, difficulty: "medium", category: self.selectGenreBtn.tag, completionHandler: {success in
                                    if success == true {
                                        print("MOVED ON TO LOAD MEDIUM")
                                        if Quiz.quizzes.count <= 0 {
                                            DispatchQueue.main.async {
                                                NetworkService.shared.loadQuiz(type: self.type, difficulty: "hard", category: self.selectGenreBtn.tag, completionHandler: {success in
                                                    if success == true {
                                                        print("MOVED ON TO HARD")
                                                        if Quiz.quizzes.count <= 0{
                                                            DispatchQueue.main.async {
                                                                alertActionBasic(viewController: self, title: "Error", message: "Could not load this Multiple Choice quiz. Please select a different genre or try again later.", completionHandler: {_ in})
                                                            }

                                                        } else {
                                                            self.quizSetupTimer.invalidate()
                                                            DispatchQueue.main.async {
                                                                self.performSegue(withIdentifier: "playMC", sender: self)
                                                            }
                                                            
                                                        }
                                                    }
                                                })
                                            }
  
                                        } else {
                                            self.quizSetupTimer.invalidate()
                                            DispatchQueue.main.async {
                                                self.performSegue(withIdentifier:"playMC", sender: self)
                                            }
                                            
                                        }
                                    }
                                })
                                
                            } else {
                                self.quizSetupTimer.invalidate()
                                self.performSegue(withIdentifier: "playMC", sender: self)
                            }
                        }
                    }
                })
            }
        }
    }
    
    //MARK: Setup Btns on Load
    ///disables the necessary buttons on load (view will appear)
    func setupBtnsOnLoad(){
        self.selectQuizTypeBtn.resetMenu()
        self.selectGenreBtn.resetMenu()
        self.selectDifficultyBtn.resetMenu()
        self.selectGenreBtn.disable()
        self.selectDifficultyBtn.disable()
        self.startQuizBtn.disable()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            // Fallback on earlier versions
            return .darkContent
            
        }
    }
    @IBAction func supportBtnAction(_ sender: Any) {
        self.performSegue(withIdentifier: "supportPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playTF"{
            if let destination = segue.destination as? QuizPlayingVC{
                destination.type = self.type
            }
        }
    }
}
