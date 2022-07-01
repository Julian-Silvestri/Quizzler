//
//  QuizLabels.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-21.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

class QuizLabels: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel()
    }
    func setupLabel(){
        self.textColor = UIColor.white
        //self.font = UIFont(name: "Avenir", size: 66)
    }
}
