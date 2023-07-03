//
//  LoginScreen.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-08-17.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit
import CryptoKit

class LoginScreenVC: UIViewController {

    @IBOutlet weak var openTDBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var playBtn: UIButton!
    
    var titlesOfQuizzes = [String]()
    var descriptionOfQuizzes = [String]()
    var imagesForCell = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playBtn.layer.cornerRadius = 12
        self.titleLabel.textColor = UIColor.black
        NetworkService.shared.grabToken(completionHandler: {success in
            if success == true {
                print("good to go")
                print(NetworkService.secrectKey[0].token)
            }
        })
        filterOutQuizzes(completionHandler: {_ in})
        
        
//        loadQuizzes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func playBtnAction(_ sender: Any) {
        CustomLoader.instance.showLoaderView()

        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            filterQuizzes(completionHandler: {success in
                if success == true {
                    CustomLoader.instance.hideLoaderView()
                    self.performSegue(withIdentifier: "login", sender: self)
                }
                print("DUMP HERE!  ")
                dump(QuizCount.quizCount)
                print("TOTAL QUIZ COUNT FOR EASY QUESTIONS \(QuizCount.quizCount.filter({$0.categoryQuestionCount.totalEasyQuestionCount > 20 }))")
            })
        })


        
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
//        UIApplication.shared.canOpenURL((URL(string: "https://opentdb.com/")!))
//        print("lets go")
//        filterOutQuizzes(completionHandler: {success in
//            if success == true {
//                CustomLoader.instance.hideLoaderView()
//            }
//        })

    }
    
    func filterOutQuizzes(completionHandler: @escaping(Bool)->Void){
//        9 = General Knowledge
//        10 = Entertainment: Books
//        11 = Entertainment: Film
//        12 = Entertainment: Music
//        13 = Entertainment: Musicals and Theatres
//        14 = Entertainment: Television
//        15 = Entertainment: Video Games
//        16 = Entertainment: Board Games
//        17 = Science and Nature
//        18 = Science: Computers
//        19 = Science: Mathematics
//        20 = Mythology
//        21 = Sports
//        22 = Geography
//        23 = History
//        24 = Politics
//        25 = Art
//        26 = Celebrities
//        27 = Animals
//        28 = Vehicles
//        29 = Entertainment: Comics
//        30 = Science: Gadgets
//        31 = Entertainment: Japanese Anime and Manga
//        32 = Entertainment: Cartoon and Animation

        for i in 9...32{
            NetworkService.shared.quizCount(category: i, completionHandler: {success in
                if success == true {
                    return
                }
            })
        }
    }
}

