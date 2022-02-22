//
//  SubmitAnswerButton.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-21.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

@IBDesignable
class SubmitAnswerButton: UIButton {

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    
    func setupButton(){
        self.layer.cornerRadius = 8
        self.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        self.titleLabel?.textColor = UIColor.white
    }

}
