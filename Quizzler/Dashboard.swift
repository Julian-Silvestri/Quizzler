//
//  Dashboard.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-08-22.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit

class Dashboard: UIViewController {

    @IBOutlet weak var startRecentQuizz: UIButton!
    @IBOutlet weak var recentQuizScore: UILabel!
    @IBOutlet weak var recentQuizImage: UIImageView!
    @IBOutlet weak var recentQuizTitle: UILabel!
    @IBOutlet weak var highscore: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var masteredQuizes: UIButton!
    @IBOutlet weak var startQuizBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startQuizBtn.layer.cornerRadius = 5
        if self.traitCollection.userInterfaceStyle == .dark {
            
            // User Interface is Dark
            self.userName.textColor = UIColor.black
            self.recentQuizTitle.textColor = UIColor.black
            //self.masteredQuizes.layer.borderColor = hexStringToUIColor(hex: "234C49").cgColor
            //self.masteredQuizes.layer.borderWidth = 1
            //self.highScoreTitle.textColor = UIColor.black
        } else {
            // User Interface is Light
            self.userName.textColor = UIColor.black
            self.recentQuizTitle.textColor = UIColor.black
            //self.masteredQuizes.layer.borderColor = hexStringToUIColor(hex: "234C49").cgColor
            //self.masteredQuizes.layer.borderWidth = 1
            //self.highScoreTitle.textColor = UIColor.black
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startQuiz(_ sender: Any) {
        self.performSegue(withIdentifier: "playQuiz", sender: self)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            // Fallback on earlier versions
            return .default
            
        }
    }
}
