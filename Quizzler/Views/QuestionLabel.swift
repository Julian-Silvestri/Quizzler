//
//  QuestionLabel.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-24.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

class QuestionLabel: UILabel {

    let fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let fontName = UIFont(name: "Avenir", size: 18)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel()
    }
    
    func setupLabel(){
        self.font = fontName
        self.textColor = fontColor
    }

}
