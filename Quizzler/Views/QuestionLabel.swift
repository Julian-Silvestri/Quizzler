//
//  QuestionLabel.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-24.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

class QuestionLabel: UILabel {

    let fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let fontName = UIFont(name: "Avenir-Next", size: 22)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel()
    }
    
    func setupLabel(){
        self.font = fontName
        self.textColor = fontColor
    }

}
