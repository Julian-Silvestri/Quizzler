//
//  GenreButtonMenu.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-21.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

class GenreButtonMenu: UIButton {
    
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
    
        
        DispatchQueue.main.async {
            for values in QuizCount.quizCount{
                print("CATEGORY ID -> \(values.categoryID) , Hard Count -> \(values.categoryQuestionCount.totalHardQuestionCount)")
                if values.categoryID == 9 {
                    let numberOfEasyQuizzes = values.categoryQuestionCount.totalEasyQuestionCount/20
                    let numberOfMediumQuizzes = values.categoryQuestionCount.totalMediumQuestionCount/20
                    let numberOfHardQuizzes = values.categoryQuestionCount.totalHardQuestionCount/20
                } else if values.categoryID == 9 {
                    
                }else if values.categoryID == 10 {
                    
                }else if values.categoryID == 11 {
                    
                }else if values.categoryID == 12 {
                    
                }else if values.categoryID == 13 {
                    
                }else if values.categoryID == 14 {
                    
                }else if values.categoryID == 15 {
                    
                }else if values.categoryID == 16 {
                    
                }else if values.categoryID == 17 {
                    
                }else if values.categoryID == 18 {
                    
                }else if values.categoryID == 19 {
                    
                }else if values.categoryID == 20 {
                    
                }else if values.categoryID == 21 {
                    
                }else if values.categoryID == 22 {
                    
                }else if values.categoryID == 23 {
                    
                }else if values.categoryID == 24 {
                    
                }else if values.categoryID == 25 {
                    
                }else if values.categoryID == 26 {
                    
                }else if values.categoryID == 27 {
                    
                }else if values.categoryID == 28 {
                    
                }else if values.categoryID == 29 {
                    
                }else if values.categoryID == 30 {
                    
                }else if values.categoryID == 31 {
                    
                }else if values.categoryID == 32 {
                    
                }
            }

        }
     
        
        let general = UIAction(title: "General Knowledge", image: nil) { (action) in
            self.setTitle("General Knowledge", for: .normal)
            self.tag = 9
        }
        let entertainmentBooks = UIAction(title: "Entertainment: Books", image: nil) { (action) in
            self.setTitle("Entertainment: Books", for: .normal)
            self.tag = 10
        }
        let entertainmentFilm = UIAction(title: "Entertainment: Film", image: nil) { (action) in
            self.setTitle("Entertainment: Film", for: .normal)
            self.tag = 11
        }
        let entertainmentMusic = UIAction(title: "Entertainment: Music", image: nil) { (action) in
            self.setTitle("Entertainment: Music", for: .normal)
            self.tag = 12
        }
        let entertainmentMusicalsTheatres = UIAction(title: "Entertainment: Musicals and Theatres", image: nil) { (action) in
            self.setTitle("Entertainment: Musicals and Theatres", for: .normal)
            self.tag = 13
        }
        let entertainmentTelevision = UIAction(title: "Entertainment: Television", image: nil) { (action) in
            self.setTitle("Entertainment: Television", for: .normal)
            self.tag = 14
        }
        let entertainmentVideoGames = UIAction(title: "Entertainment: Video Games", image: nil) { (action) in
            self.setTitle("Entertainment: Video Games", for: .normal)
            self.tag = 15
        }
        let entertainmentBoardGames = UIAction(title: "Entertainment: Board Games", image: nil) { (action) in
            self.setTitle("Entertainment: Board Games", for: .normal)
            self.tag = 16
        }
        let scienceAndNature = UIAction(title: "Science and Nature", image: nil) { (action) in
            self.setTitle("Science and Nature", for: .normal)
            self.tag = 17
        }
        let scienceComputers = UIAction(title: "Science: Computers", image: nil) { (action) in
            self.setTitle("Science: Computers", for: .normal)
            self.tag = 18
        }
        let scienceMathematics = UIAction(title: "Science: Mathematics", image: nil) { (action) in
            self.setTitle("Science: Mathematics", for: .normal)
            self.tag = 19
        }
        let mythology = UIAction(title: "Mythology", image: nil) { (action) in
            self.setTitle("Mythology", for: .normal)
            self.tag = 20
        }
        let sports = UIAction(title: "Sports", image: nil) { (action) in
            self.setTitle("Sports", for: .normal)
            self.tag = 21
        }
        let geography = UIAction(title: "Geography", image: nil) { (action) in
            self.setTitle("Geography", for: .normal)
            self.tag = 22
        }
        let history = UIAction(title: "History", image: nil) { (action) in
            self.setTitle("History", for: .normal)
            self.tag = 23
        }
        let politics = UIAction(title: "Politics", image: nil) { (action) in
            self.setTitle("Politics", for: .normal)
            self.tag = 24
        }
        let art = UIAction(title: "Art", image: nil) { (action) in
            self.setTitle("Art", for: .normal)
            self.tag = 25
        }
        let celebrities = UIAction(title: "Celebrities", image: nil) { (action) in
            self.setTitle("Celebrities", for: .normal)
            self.tag = 26
        }
        let animals = UIAction(title: "Animals", image: nil) { (action) in
            self.setTitle("Animals", for: .normal)
            self.tag = 27
        }
        let vehicles = UIAction(title: "Vehicles", image: nil) { (action) in
            self.setTitle("Vehicles", for: .normal)
            self.tag = 28
        }
        let entertainmentComics = UIAction(title: "Entertainment: Comics", image: nil) { (action) in
            self.setTitle("Entertainment: Comics", for: .normal)
            self.tag = 29
        }
        let scienceGadgets = UIAction(title: "Science: Gadgets", image: nil) { (action) in
            self.setTitle("Science: Gadgets", for: .normal)
            self.tag = 30
        }
        let entertainmentJapaneseAnimeManga = UIAction(title: "Entertainment: Japanese Anime and Manga", image: nil) { (action) in
            self.setTitle("Entertainment: Japanese Anime and Manga", for: .normal)
            self.tag = 31
        }
        let entertainmentCartoonAnimation = UIAction(title: "Entertainment: Cartoon and Animation", image: nil) { (action) in
            self.setTitle("Entertainment: Cartoon and Animation", for: .normal)
            self.tag = 32
        }
    
        let menu = UIMenu(title: "Genre", children: [general, entertainmentBooks, entertainmentFilm,entertainmentMusic,entertainmentMusicalsTheatres,entertainmentTelevision,entertainmentVideoGames,entertainmentVideoGames,entertainmentBoardGames,scienceAndNature,scienceComputers,scienceMathematics,mythology,sports,geography,history,politics,art,celebrities,animals,vehicles,entertainmentComics,scienceGadgets,entertainmentJapaneseAnimeManga,entertainmentCartoonAnimation])
        self.menu = menu
        self.showsMenuAsPrimaryAction = true
        //barItem.menu = menu
    }

}
