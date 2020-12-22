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
    
    var titlesOfQuizzes = [String]()
    var descriptionOfQuizzes = [String]()
    var imagesForCell = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signInWithGoogle.layer.cornerRadius = 5
        self.signInWithFacebook.layer.cornerRadius = 5
        self.signInWithApple.layer.cornerRadius = 5
//        self.titlesOfQuizzes = ["Art & History" , "Canadian Politics", "U.S Politics", "Animals in North America", "90's Music","Buildings of The World","Fact or Fiction?","Math's and Sciences", "Historical Figures, 20th century", "N.H.L", "M.L.B", "N.B.A", "Olympic History","Rome", "Chinese Empire - Imperial Era" , "French Revolution", "Famous Explorer's"]
//        self.descriptionOfQuizzes = ["This quiz will teset your knowledge about all things art and history in the last 100 years.", "Learn all about canadian politics in the last two decade or so.", "Find out what happened in the last two decades in United States politics", "Do you know all the native animals to north america? Take this quiz to find out everything you need to know about them!" , "Rock on! And some other stuff. Test your skills on music from the 90's", "Do you know what the tallest building in the world is? Or the smallest one ever? Take the quiz to find out that and more!" , "Find out if you can filter out the fake news!", "Do you know your basic math's and science's? I sure hope you do. We will give you a certificate of completion to show others you do.","This quiz will test your knowledge on historical figures that have shaped the world in the 20th century." , "Take this quiz to learn all about the N.H.L from both the players to the organization", "Take this quiz to learn all about the M.L.B from both the players to the organization." , "Take this quiz to learn all about the N.B.A from both the players to the organization." , "This quiz focuses on the overall history of the Olympics, from it's origin to what we know and love today." , "Learn all about Rome from its creation in 31BC to its fall in 1453CE" , "Do you know the wholse story behind the Chinese empire? Find out if you do by taking this quiz.", "Test your knowledge about the french revolution. Do you know what Bastille Day is?" , "Prepare to be shocked about what you didn't know about the most famous explorers of our time."]
//        self.imagesForCell = ["emilyCarr","canadianPolitics","usPolitics","animalsOfNorthAmerica","90s-music","buildingsOfTheWorld","factOrFiction","mathScience","explorers","nhl","mlb","nba","olympicFlag","rome","china","frenchRevolution","explorers"]
//        
//        
//        Globals.quizzesInStore.append(QuizzesInStore(title: "Art & History", description: "This quiz will teset your knowledge about all things art and history in the last 100 years.", price: "$0.99", imageName: "emilyCarr"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "Canadian Politics", description: "Learn all about canadian politics in the last two decade or so.", price: "$0.99", imageName: "canadianPolitics"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "U.S Politics", description: "Find out what happened in the last two decades in United States politics.", price: "$0.99", imageName: "usPolitics"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "Animals in North America", description: "Do you know all the native animals to north america? Take this quiz to find out everything you need to know about them!", price: "$0.99", imageName: "animalsOfNorthAmerica"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "90's Music", description: "Rock on! And some other stuff. Test your skills on music from the 90's", price: "$0.99", imageName: "90s-music"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "Buildings of The World", description: "Do you know what the tallest building in the world is? Or the smallest one ever? Take the quiz to find out that and more!", price: "$0.99", imageName: "buildingsOfTheWorld"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "Fact or Fiction?", description: "Find out if you can filter out the fake news!", price: "$0.99", imageName: "factOrFiction"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "Math's and Sciences", description: "Do you know your basic math's and science's? I sure hope you do. We will give you a certificate of completion to show others you do.", price: "$0.99", imageName: "mathScience"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "Historical Figures, 20th century", description: "This quiz will test your knowledge on historical figures that have shaped the world in the 20th century.", price: "$0.99", imageName: "explorers"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "N.H.L", description: "Take this quiz to learn all about the N.H.L from both the players to the organization", price: "$0.99", imageName: "nhl"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "M.L.B", description: "Take this quiz to learn all about the M.L.B from both the players to the organization.", price: "$0.99", imageName: "mlb"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "N.B.A", description: "Take this quiz to learn all about the N.B.A from both the players to the organization.", price: "$0.99", imageName: "nba"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "Olympic History", description: "This quiz focuses on the overall history of the Olympics, from it's origin to what we know and love today.", price: "$0.99", imageName: "olympicFlag"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "Rome", description: "Learn all about Rome from its creation in 31BC to its fall in 1453CE", price: "$0.99", imageName: "rome"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "Chinese Empire - Imperial Era", description: "Do you know the wholse story behind the Chinese empire? Find out if you do by taking this quiz.", price: "$0.99", imageName: "china"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "French Revolution", description: "Test your knowledge about the french revolution. Do you know what Bastille Day is?", price: "$0.99", imageName: "frenchRevolution"))
//        Globals.quizzesInStore.append(QuizzesInStore(title: "Famous Explorer's", description: "Prepare to be shocked about what you didn't know about the most famous explorers of our time.", price: "$0.99", imageName: "explorers"))
//        print("***********")
//        dump(Globals.quizzesInStore)
        
//        for data in self.titlesOfQuizzes{
//            for data2 in self.descriptionOfQuizzes {
//                for data3 in self.imagesForCell {
//                    Globals.userOwnedQuizes?.append(UserOwnedQuizzes(title: data, description: data2, price: "$0.99", imageName: data3))
//                }
//
//            }
//
//        }

        
        
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

