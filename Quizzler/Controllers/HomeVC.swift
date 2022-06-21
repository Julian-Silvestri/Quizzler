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
    
    var quizSetup = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quizSetup = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(quizSetupProcess), userInfo: nil, repeats: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Quiz.quizzes.removeAll()
        Quiz.quiz.removeAll()
        setupBtnsOnLoad()
        
    }

    @objc func quizSetupProcess(){
        if self.selectQuizTypeBtn.titleLabel?.text != "Select Quiz Type"  {
            self.selectGenreBtn.enable()
            if selectGenreBtn.titleLabel?.text != "Select Genre"{
                self.selectDifficultyBtn.enable()
                if self.selectDifficultyBtn.titleLabel?.text != "Select Difficulty"{
                    self.startQuizBtn.enable()
                }
            }
        }
    }
    
    @IBAction func selectTypeBtnAction(_ sender: Any) {
//        quizSetupTrackerFunction()
    }
    @IBAction func startQuiz(_ sender: Any) {
        
        if self.selectGenreBtn.titleLabel?.text == "Select Genre" || self.selectDifficultyBtn.titleLabel?.text == "Select Difficulty"{
            alertActionBasic(viewController: self, title: "Error",  message: "Please make sure you select a genre and a difficulty", completionHandler: {success in
                return
            })
        }else{
            print("TAG = \(self.selectGenreBtn.tag)")
            var difficulty = ""
            var type = ""
            
            if self.selectDifficultyBtn.tag == 1 {
                difficulty = "easy"
            } else if self.selectDifficultyBtn.tag == 2 {
                difficulty = "medium"
            } else if self.selectDifficultyBtn.tag == 3 {
                difficulty = "hard"
            }
            
            if self.selectQuizTypeBtn.tag == 1{
                type = "boolean"
                print("BOOOL")
                NetworkService.shared.loadQuiz(type: type, difficulty: difficulty, category: self.selectGenreBtn.tag, completionHandler: {success in
                    if success == true {
                        print("quiz loaded")
                        DispatchQueue.main.async {
                            if Quiz.quizzes.count <= 0 {
                                alertActionBasic(viewController: self, title: "Error", message: "Could not load this quiz", completionHandler: {_ in})
                            } else {
                                self.performSegue(withIdentifier: "playTF", sender: self)
                            }
                        }
                    }
                })
            }else if self.selectQuizTypeBtn.tag == 2 {
                type = "multiple"
                print("MULTIPLEEEEEE")
                NetworkService.shared.loadQuiz(type: type, difficulty: difficulty, category: self.selectGenreBtn.tag, completionHandler: {success in
                    if success == true {
                        print("quiz loaded")
                        DispatchQueue.main.async {
                            if Quiz.quizzes.count <= 0 {
                                alertActionBasic(viewController: self, title: "Error", message: "Could not load this quiz", completionHandler: {_ in})
                            } else {
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
}
