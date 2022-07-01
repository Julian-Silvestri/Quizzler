//
//  TypeButtonMenu.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-06-18.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

class TypeButtonMenu: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupMenu()
        self.layer.cornerRadius = 12
//        self.layer.borderColor = UIColor.black.cgColor
//        self.layer.borderWidth = 1
    }
    
    func disable(){
        self.alpha = 0.8
        self.isUserInteractionEnabled = false
    }
    
    func enable(){
        self.alpha = 1
        self.isUserInteractionEnabled = true
    }
    
    func setupMenu() {
        let trueFalse = UIAction(title: "True/False", image: nil) { (action) in
            self.setTitle("True/False", for: .normal)
            self.tag = 1
        }
        let multipleChoice = UIAction(title: "Multiple Choice", image: nil) { (action) in
            self.setTitle("Multiple Choice", for: .normal)
            self.tag = 2
        }

        let menu = UIMenu(title: "Type", children: [trueFalse, multipleChoice])
        self.menu = menu
        self.showsMenuAsPrimaryAction = true
        //barItem.menu = menu
    }
    
    func resetMenu(){
        self.setTitle("Select Quiz Type", for: .normal)
    }
//    private func createSiteMenu(actionTitle: String? = nil) {
//        let menu = UIMenu(title: "Site", image: nil, identifier: nil, options: [], children: self.menu)
//        self.menu = updateActionState(actionTitle: actionTitle, menu: menu)
//        self.showsMenuAsPrimaryAction = true
//    }
//    private func updateActionState(actionTitle: String? = nil, menu: UIMenu) -> UIMenu {
//        if let actionTitle = actionTitle {
//            menu.children.forEach { action in
//                guard let action = action as? UIAction else {
//                    return
//                }
//                if action.title == actionTitle {
//                    action.state = .on
//                }
//            }
//        } else {
//            let action = menu.children.first as? UIAction
//            action?.state = .on
//        }
//        return menu
//    }
}
