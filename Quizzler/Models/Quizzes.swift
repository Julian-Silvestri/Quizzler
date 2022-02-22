//
//  Quizzes.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-10.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import Foundation


class Quizzes:Codable {
    
    static var quizzes = [Quizzes]()
    
    let title: String
    let description: String
    let questions: [Int:String]
    let answer: [Int:String]
    let possibleAnswers: [Int:[String]]
    let imageName: String
    //let score: Int
    
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

class Secret: Codable {
    let responseCode: Int
    let responseMessage, token: String

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case responseMessage = "response_message"
        case token
    }

    init(responseCode: Int, responseMessage: String, token: String) {
        self.responseCode = responseCode
        self.responseMessage = responseMessage
        self.token = token
    }
}



// MARK: - Quiz
class Quiz: Codable {
    let responseCode: Int
    let results: [Result]
    
    static var quizzes = [Result]()
    static var quiz = [Quiz]()

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }

    init(responseCode: Int, results: [Result]) {
        self.responseCode = responseCode
        self.results = results
    }
}

// MARK: - Result
class Result: Codable {
    let category: Category
    let type: TypeEnum
    let difficulty: Difficulty
    let question, correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }

    init(category: Category, type: TypeEnum, difficulty: Difficulty, question: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.category = category
        self.type = type
        self.difficulty = difficulty
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
}

enum Category: String, Codable {
    case generalKnowledge = "General Knowledge"
}

enum Difficulty: String, Codable {
    case medium = "medium"
}

enum TypeEnum: String, Codable {
    case multiple = "multiple"
}
