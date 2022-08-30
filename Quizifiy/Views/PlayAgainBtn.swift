//
//  PlayAgainBtn.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-06-19.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

class PlayAgainBtn: UIButton {
    
    var bgColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    var tint = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setup()
    }
    
    func setup(){
        self.backgroundColor = bgColor
        self.tintColor = tint
        self.layer.cornerRadius = 12
        self.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 37)
//        self.titleLabel?.adjustsFontSizeToFitWidth = true
//        self.titleLabel?.minimumScaleFactor = 0.1
        self.titleLabel?.numberOfLines = 1
    }

}
