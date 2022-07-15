//
//  QuizSelectedVC.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-09-05.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit

class QuizSelectedVC: UIViewController {
    
    @IBOutlet weak var priceOfQuizSelectedLabel: UILabel!
    @IBOutlet weak var descriptionOfQuizSelectedLabel: UILabel!
    @IBOutlet weak var titleOfQuizSelectedLabel: UILabel!
    
    var titleOfItemSelected = ""
    var descriptionOfItemSelected = ""
    var priceOfItemSelected = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.priceOfQuizSelectedLabel.text = self.priceOfItemSelected
        self.descriptionOfQuizSelectedLabel.text = self.descriptionOfItemSelected
        self.titleOfQuizSelectedLabel.text = self.titleOfItemSelected
        // Do any additional setup after loading the view.
    }
    


}
