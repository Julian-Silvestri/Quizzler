//
//  Quizzes.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-08-22.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit

class userQuizzesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var scoreOfQuiz: UILabel!
    @IBOutlet weak var titleOfQuiz: UILabel!
}

class Quizzes: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var usersQuizCollection: UICollectionView!
    @IBOutlet weak var yourQuizzesTitle: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.usersQuizCollection.delegate = self
        self.usersQuizCollection.dataSource = self
        
        if self.traitCollection.userInterfaceStyle  == .dark{
            self.usersQuizCollection.backgroundColor = UIColor.clear
            self.yourQuizzesTitle.textColor = UIColor.black

        } else {
            self.usersQuizCollection.backgroundColor = UIColor.clear
            self.yourQuizzesTitle.textColor = UIColor.black
            
        }

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
        //return Globals.userOwnedQuizes?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = usersQuizCollection.dequeueReusableCell(withReuseIdentifier: "usersQuizesCollectionCell", for: indexPath) as? userQuizzesCollectionCell
        
        if self.traitCollection.userInterfaceStyle == .dark {
            cell?.titleOfQuiz.textColor = UIColor.black
            cell?.scoreOfQuiz.textColor = UIColor.black

        } else {
            cell?.titleOfQuiz.textColor = UIColor.black
            cell?.scoreOfQuiz.textColor = UIColor.black
            
        }
        
        cell!.titleOfQuiz.text = "Canada in the 90's"
        
        
        return cell!
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
