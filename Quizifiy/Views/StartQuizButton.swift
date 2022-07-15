//
//  StartButton.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-21.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

class StartQuizButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel()
    }
    
    func setupLabel() {
        self.layer.cornerRadius = 8
        
    }
    
    func disable(){
        self.alpha = 0.8
        self.isUserInteractionEnabled = false
    }
    
    func enable(){
        self.alpha = 1
        self.isUserInteractionEnabled = true
    }


}
