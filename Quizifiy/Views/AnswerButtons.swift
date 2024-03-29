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
    
    let selectedColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    let deSelectedColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let myFont = UIFont(name: "Avenir-Next", size: 22)
    
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
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font:myFont ?? UIFont(name: "Avenir-Next", size: 22),
//            .strokeColor:UIColor.white
//        ]
        self.titleLabel?.textColor = UIColor.white
//        self.att
        self.tintColor = UIColor.white
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleColor(for: .normal)
    }
    
    func selected(){
        self.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    }
    
    func deSelected(){
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    
}
