//
//  ShowResultsOfQuizVC.swift
//  Quizify
//
//  Created by Julian Silvestri on 2022-08-30.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit


class ResultsOfQuizTableViewCell: UITableViewCell {
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var yourAnswerLabel: UILabel!
}

class ShowResultsOfQuizVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var yourScoreResultsLabel: QuestionLabel!
    @IBOutlet weak var resultsTitleLabel: QuestionLabel!
    @IBOutlet weak var resultsOfQuizTableView: UITableView!
    
    lazy var playersAnswers = [String]()
    lazy var playersScore = Int()
    var incorrectAnswers = [String]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yourScoreResultsLabel.text = "\(playersScore)/20"
        self.resultsOfQuizTableView.delegate = self
        self.resultsOfQuizTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        /// not sure what i was thinking, im dumb
//        while count <= 19 {
//            for values in Quiz.quizzes[count].incorrectAnswers{
//                self.incorrectAnswers.append(values)
//            }
//            count += 1
//        }
//
//        print(incorrectAnswers)

//        quiz.quizzes[x].correctAnswer, incorrectAnswers: Quiz.quizzes[x].incorrectAnswers
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.resultsOfQuizTableView.rowHeight = 220
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
//        let data = self.incorrectAnswers
    
        if let cell = self.resultsOfQuizTableView.dequeueReusableCell(withIdentifier: "results", for: indexPath) as? ResultsOfQuizTableViewCell{
            cell.questionNumberLabel.text = "\(indexPath.row + 1)"
            cell.questionTextLabel.text = "\(Quiz.quizzes[indexPath.row].question)"
            cell.correctAnswerLabel.text = Quiz.quizzes[indexPath.row].correctAnswer
            cell.yourAnswerLabel.text = "\(self.playersAnswers[indexPath.row])"
            
            if cell.correctAnswerLabel.text == cell.yourAnswerLabel.text {
                cell.backgroundColor = UIColor.green
            } else {
                cell.backgroundColor = UIColor.red
            }
            return cell
        }
        
        return cell
    }
    
}
