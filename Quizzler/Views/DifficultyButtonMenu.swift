//
//  DifficultyButtonMenu.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-21.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

class DifficultyButtonMenu: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupMenu()
        self.layer.cornerRadius = 12
//        self.layer.borderColor = UIColor.black.cgColor
//        self.layer.borderWidth = 1
    }
    
    func setupMenu() {
        let easy = UIAction(title: "Easy", image: nil) { (action) in
            self.setTitle("Easy", for: .normal)
            self.tag = 1
        }
        let medium = UIAction(title: "Medium", image: nil) { (action) in
            self.setTitle("Medium", for: .normal)
            self.tag = 2
        }
        let hard = UIAction(title: "Hard", image: nil) { (action) in
            self.setTitle("Hard", for: .normal)
            self.tag = 3
        }
        let menu = UIMenu(title: "Difficulty", children: [easy, medium, hard])
        self.menu = menu
        self.showsMenuAsPrimaryAction = true
        //barItem.menu = menu
    }
    
}
