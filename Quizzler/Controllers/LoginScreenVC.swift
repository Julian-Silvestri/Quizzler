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
        filterOutQuizzes()
        
        
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

        
        ///WHY DOES THIS NOT WORK :(
        while self.count < 32 {
            NetworkService.shared.quizCount(category: self.count, completionHandler: {success in
                if success == true {
//                    self.count+=1
                    return
                }
            })
            self.count+=1
        }

        
        //I hate my life
//        NetworkService.shared.quizCount(category: 9, completionHandler: {success in
//            if success == true {
//
//                NetworkService.shared.quizCount(category: 10, completionHandler: {success in
//                    if success == true {
//
//                        NetworkService.shared.quizCount(category: 11, completionHandler: {success in
//                            if success == true {
//
//                                NetworkService.shared.quizCount(category: 12, completionHandler: {success in
//                                    if success == true {
//
//                                        NetworkService.shared.quizCount(category: 13, completionHandler: {success in
//                                            if success == true {
//
//                                                NetworkService.shared.quizCount(category: 14, completionHandler: {success in
//                                                    if success == true {
//
//                                                        NetworkService.shared.quizCount(category: 15, completionHandler: {success in
//                                                            if success == true {
//
//                                                                NetworkService.shared.quizCount(category: 16, completionHandler: {success in
//                                                                    if success == true {
//
//                                                                        NetworkService.shared.quizCount(category: 17, completionHandler: {success in
//                                                                            if success == true {
//
//                                                                                NetworkService.shared.quizCount(category: 18, completionHandler: {success in
//                                                                                    if success == true {
//
//                                                                                        NetworkService.shared.quizCount(category: 19, completionHandler: {success in
//                                                                                            if success == true {
//
//                                                                                                NetworkService.shared.quizCount(category: 20, completionHandler: {success in
//                                                                                                    if success == true {
//
//                                                                                                        NetworkService.shared.quizCount(category: 21, completionHandler: {success in
//                                                                                                            if success == true {
//
//                                                                                                                NetworkService.shared.quizCount(category: 22, completionHandler: {success in
//                                                                                                                    if success == true {
//
//                                                                                                                        NetworkService.shared.quizCount(category: 23, completionHandler: {success in
//                                                                                                                            if success == true {
//
//                                                                                                                                NetworkService.shared.quizCount(category: 24, completionHandler: {success in
//                                                                                                                                    if success == true {
//
//                                                                                                                                        NetworkService.shared.quizCount(category: 25, completionHandler: {success in
//                                                                                                                                            if success == true {
//
//                                                                                                                                                NetworkService.shared.quizCount(category: 26, completionHandler: {success in
//                                                                                                                                                    if success == true {
//
//                                                                                                                                                        NetworkService.shared.quizCount(category: 27, completionHandler: {success in
//                                                                                                                                                            if success == true {
//
//                                                                                                                                                                NetworkService.shared.quizCount(category: 28, completionHandler: {success in
//                                                                                                                                                                    if success == true {
//
//                                                                                                                                                                        NetworkService.shared.quizCount(category: 29, completionHandler: {success in
//                                                                                                                                                                            if success == true {
//
//                                                                                                                                                                                NetworkService.shared.quizCount(category: 30, completionHandler: {success in
//                                                                                                                                                                                    if success == true {
//
//                                                                                                                                                                                        NetworkService.shared.quizCount(category: 31, completionHandler: {success in
//                                                                                                                                                                                            if success == true {
//
//                                                                                                                                                                                                NetworkService.shared.quizCount(category: 32, completionHandler: {success in
//                                                                                                                                                                                                    if success == true {
//
//                                                                                                                                                                                                        return
//                                                                                                                                                                                                    }
//                                                                                                                                                                                                })
//                                                                                                                                                                                            }
//                                                                                                                                                                                        })
//                                                                                                                                                                                    }
//                                                                                                                                                                                })
//                                                                                                                                                                            }
//                                                                                                                                                                        })
//                                                                                                                                                                    }
//                                                                                                                                                                })
//                                                                                                                                                            }
//                                                                                                                                                        })
//                                                                                                                                                    }
//                                                                                                                                                })
//                                                                                                                                            }
//                                                                                                                                        })
//                                                                                                                                    }
//                                                                                                                                })
//                                                                                                                            }
//                                                                                                                        })
//                                                                                                                    }
//                                                                                                                })
//                                                                                                            }
//                                                                                                        })
//                                                                                                    }
//                                                                                                })
//                                                                                            }
//                                                                                        })
//                                                                                    }
//                                                                                })
//                                                                            }
//                                                                        })
//                                                                    }
//                                                                })
//                                                            }
//                                                        })
//                                                    }
//                                                })
//                                            }
//                                        })
//                                    }
//                                })
//                            }
//                        })
//                    }
//                })
//            }
//        })
    }
}

