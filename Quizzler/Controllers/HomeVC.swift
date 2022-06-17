//
//  Dashboard.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-08-22.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//


import GoogleMobileAds

class HomeVC: UIViewController {

    @IBOutlet weak var startRecentQuizz: UIButton!
    @IBOutlet weak var startQuizBtn: UIButton!
    @IBOutlet weak var selectGenreBtn: GenreButtonMenu!
    @IBOutlet weak var selectDifficultyBtn: DifficultyButtonMenu!
    
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Quiz.quizzes.removeAll()
        Quiz.quiz.removeAll()
    }
    
    @IBAction func startQuiz(_ sender: Any) {
        
        if self.selectGenreBtn.titleLabel?.text == "Select Genre" || self.selectDifficultyBtn.titleLabel?.text == "Select Difficulty"{
            alertActionBasic(viewController: self, title: "Error", message: "Please make sure you select a genre and a difficulty", completionHandler: {success in
                return
            })
        }else{
            print("TAG = \(self.selectGenreBtn.tag)")
            var difficulty = ""
            
            if self.selectDifficultyBtn.tag == 1 {
                difficulty = "easy"
            } else if self.selectDifficultyBtn.tag == 2 {
                difficulty = "medium"
            } else if self.selectDifficultyBtn.tag == 3 {
                difficulty = "hard"
            }
            
            NetworkService.shared.loadQuiz(difficulty: difficulty, category: self.selectGenreBtn.tag, completionHandler: {success in
                if success == true {
                    print("quiz loaded")
                    DispatchQueue.main.async {
                        if Quiz.quizzes.count <= 0 {
                            alertActionBasic(viewController: self, title: "Error", message: "Could not load this quiz", completionHandler: {_ in})
                        } else {
                            self.performSegue(withIdentifier: "play", sender: self)
                        }
                    }
                }
            })
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
