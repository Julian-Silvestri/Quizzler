//
//  Dashboard.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-08-22.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit

class Dashboard: UIViewController {

    @IBOutlet weak var highscore: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            self.userName.textColor = UIColor.black
            //self.highScoreTitle.textColor = UIColor.black
        } else {
            // User Interface is Light
            self.userName.textColor = UIColor.black
            //self.highScoreTitle.textColor = UIColor.black
        }
        // Do any additional setup after loading the view.
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
