//
//  GenreButtonMenu.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-21.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

class GenreButtonMenu: UIButton {
    var generalKnowledge = Bool()
    var entertainmentBooks_ = Bool()
    var entertainmentFilm_ = Bool()
    var entertainmentMusic_ = Bool()
    var entertainmentMusicalsTheaters_ = Bool()
    var entertainmentTelevision_ = Bool()
    var entertainmentVideoGames_ = Bool()
    var entertainmentBoardGames_ = Bool()
    var entertainmentComics_ = Bool()
    var entertainmentJapanAnime_ = Bool()
    var entertainmentCartoon_ = Bool()
    var scienceNature_ = Bool()
    var scienceComputers_ = Bool()
    var scienceMath_ = Bool()
    var mythology_ = Bool()
    var sports_ = Bool()
    var geography_ = Bool()
    var history_ = Bool()
    var politics_ = Bool()
    var art_ = Bool()
    var celebrities_ = Bool()
    var animals_ = Bool()
    var vehicles_ = Bool()
    var scienceGadgets_ = Bool()
    
    
    var filteredBtnArray = [UIAction]()

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
//
//        filterQuizzes(completionHandler: {success in
//            if(success == true){
//                
//            }
//        })
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
        
//        let menu = UIMenu(title:"Genre", children: [])
//        let menu = UIMenu(title: "Genre", children: [general, entertainmentBooks, entertainmentFilm,entertainmentMusic,entertainmentMusicalsTheatres,entertainmentTelevision,entertainmentVideoGames,entertainmentVideoGames,entertainmentBoardGames,scienceAndNature,scienceComputers,scienceMathematics,mythology,sports,geography,history,politics,art,celebrities,animals,vehicles,entertainmentComics,scienceGadgets,entertainmentJapaneseAnimeManga,entertainmentCartoonAnimation])
        
        
        
        
        ///BELOW IS THE PROPER WAY TO FILTER THE LIST I WANT
        ///however, the data with the quizzes does not have catergory ID as an Integer.
        ///the data has category as a string, ie: general knowledge , entertainment books etc...
        ///the quiz count funtion has category ID as INT, ie: general knowledge = 9 , entertainment books = 10 etc...
        ///there is no way to associate the category (string) to the category ID without doing it manually.
        ///there may be a way for me to do this by creating a new class that has the desired types,
        ///however that would sitll involve this manual process... and why do things twice.
        ///
        ///sad sad days.
        
//        for i in 9...32{
//            if QuizCount.quizCount.contains(where: {$0.categoryID == i}) {
//                for values in QuizCount.quizCount {
//                    if values.categoryID == i {
//                        let filteredQuizBtn = UIAction(title: values. , image: <#T##UIImage?#>)
//                        filteredBtnArray.append(<#T##newElement: UIAction##UIAction#>)
//                    }
//                }
//
//            }
//        }

        
        ///I hate this code below so much
        ///it hurts me just to look at it
        ///I will not give up until i resolve this embarassment.

        //this code filters the quizzes out when they do not meet the requirements. 
        for i in 9...32{
            if QuizCount.quizCount.contains(where: {$0.categoryID == i}) {
                
                if i == 9 {
                    generalKnowledge = true
                    filteredBtnArray.append(general)
                }
                if i == 10 {
                    entertainmentBooks_ = true
                    filteredBtnArray.append(entertainmentBooks)
                }
                if i == 11 {
                    entertainmentFilm_ = true
                    filteredBtnArray.append(entertainmentFilm)
                }
                if i == 12 {
                    entertainmentMusic_ = true
                    filteredBtnArray.append(entertainmentMusic)
                }
                if i == 13 {
                    entertainmentMusicalsTheaters_ = true
                    filteredBtnArray.append(entertainmentMusicalsTheatres)
                }
                if i == 14 {
                    entertainmentTelevision_ = true
                    filteredBtnArray.append(entertainmentTelevision)
                }
                if i == 15 {
                    entertainmentVideoGames_ = true
                    filteredBtnArray.append(entertainmentVideoGames)
                }
                if i == 16 {
                    entertainmentBoardGames_ = true
                    filteredBtnArray.append(entertainmentBoardGames)
                }
                if i == 17 {
                    scienceNature_ = true
                    filteredBtnArray.append(scienceAndNature)
                }
                if i == 18{
                    scienceComputers_ = true
                    filteredBtnArray.append(scienceComputers)
                }
                if i == 19{
                    scienceMath_ = true
                    filteredBtnArray.append(scienceMathematics)
                }
                if i == 20 {
                    mythology_ = true
                    filteredBtnArray.append(mythology)
                }
                if i == 21 {
                    sports_ = true
                    filteredBtnArray.append(sports)
                }
                if i == 22 {
                    geography_ = true
                    filteredBtnArray.append(geography)
                }
                if i == 23 {
                    history_ = true
                    filteredBtnArray.append(history)
                }
                if i == 24 {
                    politics_ = true
                    filteredBtnArray.append(politics)
                }
                if i == 25 {
                    art_ = true
                    filteredBtnArray.append(art)
                }
                if i == 26 {
                    celebrities_ = true
                    filteredBtnArray.append(celebrities)
                }
                if i == 27 {
                    animals_ = true
                    filteredBtnArray.append(animals)
                }
                if i == 28 {
                    vehicles_ = true
                    filteredBtnArray.append(vehicles)
                }
                if i == 29 {
                    entertainmentComics_ = true
                    filteredBtnArray.append(entertainmentComics)
                }
                if i == 30 {
                    scienceGadgets_ = true
                    filteredBtnArray.append(scienceGadgets)
                }
                if i == 31 {
                    entertainmentJapanAnime_ = true
                    filteredBtnArray.append(entertainmentJapaneseAnimeManga)
                }
                if i == 32 {
                    entertainmentCartoon_ = true
                    filteredBtnArray.append(entertainmentCartoonAnimation)
                }
            }
        }
    

        let menu = UIMenu(title:"Genre", children: filteredBtnArray)
        self.menu = menu
        self.showsMenuAsPrimaryAction = true
        
        
        //barItem.menu = menu
    }
    
    func resetMenu(){
        self.setTitle("Select Genre", for: .normal)
    }

}
