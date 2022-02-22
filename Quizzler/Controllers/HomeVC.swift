//
//  Dashboard.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-08-22.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var startRecentQuizz: UIButton!
    @IBOutlet weak var startQuizBtn: UIButton!
    @IBOutlet weak var selectGenreBtn: GenreButtonMenu!
    @IBOutlet weak var selectDifficultyBtn: DifficultyButtonMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startQuiz(_ sender: Any) {
        
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
                    self.performSegue(withIdentifier: "play", sender: self)
                }
            }
        })
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
