//
//  LoginScreen.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-08-17.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit

class LoginScreenVC: UIViewController {

    @IBOutlet weak var openTDBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var playBtn: UIButton!
    
    var titlesOfQuizzes = [String]()
    var descriptionOfQuizzes = [String]()
    var imagesForCell = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playBtn.layer.cornerRadius = 5
        self.titleLabel.textColor = UIColor.black
        NetworkService.shared.grabToken(completionHandler: {success in
            if success == true {
                print("good to go")
            }
        })
//        loadQuizzes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func playBtnAction(_ sender: Any) {
        self.performSegue(withIdentifier: "login", sender: self)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            // Fallback on earlier versions
            return .darkContent
            
        }
    }
    
    @IBAction func openTDAction(_ sender: Any) {
        UIApplication.shared.canOpenURL((URL(string: "https://opentdb.com/")!))
        print("lets go")
    }
}

