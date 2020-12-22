//
//  Classes.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-09-14.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import Foundation


class QuizInv:Codable {
    let title: String
    let description: String
    let questions: [Int:String]
    let answer: [Int:String]
    let possibleAnswers: [Int:[String]]
    let imageName: String
    
    init(title: String, description: String, questions: [Int:String],answer: [Int:String], possibleAnswers: [Int:[String]], imageName: String){
        self.title = title
        self.description = description
        self.answer = answer
        self.possibleAnswers = possibleAnswers
        self.questions = questions
        self.imageName = imageName
    }
    deinit {
        print("get out of here - User owned quizzes")
    }
}
