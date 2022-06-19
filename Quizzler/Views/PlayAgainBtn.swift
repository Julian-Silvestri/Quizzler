//
//  PlayAgainBtn.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-06-19.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

class PlayAgainBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    func setup(){
        self.layer.cornerRadius = 12
        self.titleLabel?.font = UIFont(name: "Avenir", size: 39)
    }

}
