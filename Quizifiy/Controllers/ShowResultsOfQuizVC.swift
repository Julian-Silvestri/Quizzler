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
            cell.questionNumberLabel.text = "Question: \(indexPath.row + 1)"
            cell.questionTextLabel.text = "\(decode(str:Quiz.quizzes[indexPath.row].question).string)"
//            cell.questionTextLabel.text = "\(Quiz.quizzes[indexPath.row].question)"
            cell.correctAnswerLabel.text = "Correct Answer: \(Quiz.quizzes[indexPath.row].correctAnswer)"
            cell.yourAnswerLabel.text = "Your Answer: \(self.playersAnswers[indexPath.row])"
            
            if ("\(Quiz.quizzes[indexPath.row].correctAnswer)" == "\(self.playersAnswers[indexPath.row])") {
                cell.backgroundColor = #colorLiteral(red: 0.5694975257, green: 0.8108343482, blue: 0.5884379148, alpha: 1)
            } else {
                cell.backgroundColor = #colorLiteral(red: 0.958886683, green: 0.4196015894, blue: 0.3852186799, alpha: 1)
            }
            return cell
        }
        
        return cell
    }
    
}
