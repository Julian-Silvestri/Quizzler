//
//  Store.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-08-22.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit

class quizStoreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleOfQuiz: UILabel!
    @IBOutlet weak var descriptionOfQuiz: UILabel!
    @IBOutlet weak var imageOfCell: UIImageView!
    @IBOutlet weak var priceOfQuiz: UILabel!
}

class Store: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var filterFreeBtn: UILabel!
    @IBOutlet weak var filterChallengeBtn: UILabel!
    @IBOutlet weak var filterPriceBtn: UILabel!
    @IBOutlet weak var filterNewestBtn: UILabel!
    @IBOutlet weak var filterStackButtons: UIStackView!
    @IBOutlet weak var quizStoreLabel: UILabel!
    @IBOutlet weak var quizStoreCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var titlesOfQuizes = [String]()
    var descriptionsOfQuizes = [String]()
    var pricesOfQuizes = [String]()
    var titleOfItemSelected = ""
    var descriptionOfItemSelected = ""
    var priceOfItemSelected = ""
    var imagesForCell = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //extension function below
        hideKeyboardWhenTappedAround()
        
        self.imagesForCell = ["emilyCarr","canadianPolitics","usPolitics","animalsOfNorthAmerica","90Music","buildingsOfTheWorld","factOrFiction","mathScience","historicalFigures20"]
        
        self.quizStoreCollectionView.delegate = self
        self.quizStoreCollectionView.dataSource = self
        
        self.filterChallengeBtn.clipsToBounds = true
        self.filterNewestBtn.clipsToBounds = true
        self.filterPriceBtn.clipsToBounds = true
        self.filterFreeBtn.clipsToBounds = true
        
        self.filterChallengeBtn.layer.cornerRadius = 5
        self.filterNewestBtn.layer.cornerRadius = 5
        self.filterPriceBtn.layer.cornerRadius = 5
        self.filterFreeBtn.layer.cornerRadius = 5
        
        self.titlesOfQuizes = ["Art & History" , "Canadian Politics", "U.S Politics", "Animals in North America", "90's Music","Buildings of The World","Fact or Fiction?","Math's and Sciences", "Historical Figures, 20th century", "N.H.L", "M.L.B", "N.B.A", "Olympic History","Rome", "Chinese Empire - Imperial Era" , "French Revolution", "Famous Explorer's"]
        self.descriptionsOfQuizes = ["This quiz will teset your knowledge about all things art and history in the last 100 years.", "Learn all about canadian politics in the last two decade or so.", "Find out what happened in the last two decades in United States politics", "Do you know all the native animals to north america? Take this quiz to find out everything you need to know about them!" , "Rock on! And some other stuff. Test your skills on music from the 90's", "Do you know what the tallest building in the world is? Or the smallest one ever? Take the quiz to find out that and more!" , "Find out if you can filter out the fake news!", "Do you know your basic math's and science's? I sure hope you do. We will give you a certificate of completion to show others you do.","This quiz will test your knowledge on historical figures that have shaped the world in the 20th century." , "Take this quiz to learn all about the N.H.L from both the players to the organization", "Take this quiz to learn all about the M.L.B from both the players to the organization." , "Take this quiz to learn all about the N.B.A from both the players to the organization." , "This quiz focuses on the overall history of the Olympics, from it's origin to what we know and love today." , "Learn all about Rome from its creation in 31BC to its fall in 1453CE" , "Do you know the wholse story behind the Chinese empire? Find out if you do by taking this quiz.", "Test your knowledge about the french revolution. Do you know what Bastille Day is?" , "Prepare to be shocked about what you didn't know about the most famous explorers of our time."]
        self.imagesForCell = ["emilyCarr","canadianPolitics","usPolitics","animalsOfNorthAmerica","90s-music","buildingsOfTheWorld","factOrFiction","mathScience","expolrers","nhl","mlb","nba","olympicFlag","rome","china","frenchRevolution","explorers"]
        
        
        if self.traitCollection.userInterfaceStyle == .dark {
            self.quizStoreCollectionView.backgroundColor = UIColor.clear
            self.quizStoreLabel.textColor = UIColor.black
            self.filterFreeBtn.textColor = UIColor.white
            self.filterPriceBtn.textColor = UIColor.white
            self.filterNewestBtn.textColor = UIColor.white
            self.filterChallengeBtn.textColor = UIColor.white
//            self.searchBar.backgroundColor = UIColor.clear
//            self.searchBar.layer.backgroundColor = UIColor.clear.cgColor
            //self.searchBar.tintColor = UIColor.white
    
        } else {
            self.quizStoreCollectionView.backgroundColor = UIColor.clear
            self.quizStoreLabel.textColor = UIColor.black
            self.filterFreeBtn.textColor = UIColor.white
            self.filterPriceBtn.textColor = UIColor.white
            self.filterNewestBtn.textColor = UIColor.white
            self.filterChallengeBtn.textColor = UIColor.white
//            self.searchBar.backgroundColor = UIColor.clear
//            self.searchBar.layer.backgroundColor = UIColor.clear.cgColor
            //self.searchBar.tintColor = UIColor.white
            
        }

        // Do any additional setup after loading the view.
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle{
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            // Fallback on earlier versions
            return .default
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return Globals.quizzesInStore?.count ?? 10
        return self.titlesOfQuizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quizStoreCollectionView.dequeueReusableCell(withReuseIdentifier: "featuredQuizCell", for: indexPath) as! quizStoreCollectionViewCell
        
        cell.titleOfQuiz.text = self.titlesOfQuizes[indexPath.row]
        cell.imageOfCell.image = UIImage(named: self.imagesForCell[indexPath.row])
        //cell.descriptionOfQuiz.text = self.descriptionsOfQuizes[indexPath.row]
        //cell.priceOfQuiz.text = "$0.99"
        cell.layer.cornerRadius = 5
        cell.imageOfCell.layer.cornerRadius = cell.frame.size.height/2
        
        if self.traitCollection.userInterfaceStyle == .dark {
            //cell.titleOfQuiz.textColor = UIColor.white
            cell.titleOfQuiz.textColor = UIColor.black
            //cell.descriptionOfQuiz.textColor = UIColor.black
            //cell.priceOfQuiz.textColor = UIColor.black
        } else {
            self.quizStoreCollectionView.backgroundColor = UIColor.clear
            //cell.titleOfQuiz.textColor = UIColor.white
            cell.titleOfQuiz.textColor = UIColor.black
            //cell.descriptionOfQuiz.textColor = UIColor.black
            //cell.priceOfQuiz.textColor = UIColor.black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.titleOfItemSelected = self.titlesOfQuizes[indexPath.row]
        self.descriptionOfItemSelected = self.descriptionsOfQuizes[indexPath.row]
        self.priceOfItemSelected = "$0.99"
        
        self.performSegue(withIdentifier: "quizSelected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizSelected" {
            if let destination = segue.destination as? QuizSelectedVC {
                destination.descriptionOfItemSelected = self.descriptionOfItemSelected
                destination.titleOfItemSelected = self.titleOfItemSelected
                destination.priceOfItemSelected = self.priceOfItemSelected
            }
        }
    }
    

}

extension UIViewController {

   func hideKeyboardWhenTappedAround() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
   }

   @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
       view.endEditing(true)

       if let nav = self.navigationController {
           nav.view.endEditing(true)
       }
   }
}
