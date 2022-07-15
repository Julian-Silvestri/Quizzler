//
//  QuizPlayingNumber.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-21.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

@IBDesignable
class QuizPlayingNumber: UILabel {

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupLabel()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLabel()
    }
    
    func setupLabel(){
        self.font = UIFont(name: "Avenir", size: 66)
        self.textColor = UIColor.black
        
        
    }

}
