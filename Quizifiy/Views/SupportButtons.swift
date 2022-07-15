//
//  SupportButtons.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-07-14.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

@IBDesignable
class SupportButtons: UIButton {
    
    var bgColor = #colorLiteral(red: 0.9570063949, green: 0.8126075864, blue: 0.3806093335, alpha: 1)
    var txtColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    func setup(){
        self.layer.cornerRadius = 12
        self.backgroundColor = bgColor
        self.titleLabel?.font = UIFont(name: "Avenir Next", size: 38)
        self.titleLabel?.textColor = txtColor
    }
    
}
