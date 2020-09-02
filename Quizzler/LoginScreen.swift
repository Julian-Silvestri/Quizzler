//
//  LoginScreen.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-08-17.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit

class LoginScreen: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInWithApple: UIButton!
    @IBOutlet weak var signInWithGoogle: UIButton!
    @IBOutlet weak var signInWithFacebook: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signInWithGoogle.layer.cornerRadius = 5
        self.signInWithFacebook.layer.cornerRadius = 5
        self.signInWithApple.layer.cornerRadius = 5
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            self.titleLabel.textColor = UIColor.black
        } else {
            // User Interface is Light
            self.titleLabel.textColor = UIColor.black
        }
    }
    @IBAction func loginWithFacebookAction(_ sender: Any) {
        self.performSegue(withIdentifier: "login", sender: self)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            // Fallback on earlier versions
            return .default
            
        }
    }
    
}

