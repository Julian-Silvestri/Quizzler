//
//  AnswerButtons.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-21.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

@IBDesignable
class AnswerButtons: UIButton {
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupButtons()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButtons()
    }
    
    func setupButtons(){
        self.layer.cornerRadius = 12
        self.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.titleLabel?.textColor = UIColor.white
        self.setTitleColor(UIColor.white, for: .normal)
//        self.titleColor(for: .normal)
    }
    
    func selectedAsAnswer(){
        
    }
    
}
