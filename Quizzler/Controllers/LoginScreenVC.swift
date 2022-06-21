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
    var count = 9
    
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
        filterOutQuizzes()

    }
    
    func filterOutQuizzes(){
        //9 = General Knowledge
        //10 = Entertainment: Books
        //11 = Entertainment: Film
        //12 = Entertainment: Music
        //13 = Entertainment: Musicals and Theatres
        //14 = Entertainment: Television
        //15 = Entertainment: Video Games
        //16 = Entertainment: Board Games
        //17 = Science and Nature
        //18 = Science: Computers
        //19 = Science: Mathematics
        //20 = Mythology
        //21 = Sports
        //22 = Geography
        //23 = History
        //24 = Politics
        //25 = Art
        //26 = Celebrities
        //27 = Animals
        //28 = Vehicles
        //29 = Entertainment: Comics
        //30 = Science: Gadgets
        //31 = Entertainment: Japanese Anime and Manga
        //32 = Entertainment: Cartoon and Animation
        while count <= 32{
            NetworkService.shared.quizCount(category: count, completionHandler: {success in
                if success == true {
                    return
                }
            })
            count += 1
        }
    }
}

