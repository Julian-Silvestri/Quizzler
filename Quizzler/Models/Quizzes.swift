//
//  Quizzes.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-10.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import Foundation

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
    let category, type, difficulty, question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }

    init(category: String, type: String, difficulty: String, question: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.category = category
        self.type = type
        self.difficulty = difficulty
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
}

// MARK: - Quiz True False
class QuizTrueFalse: Codable {
    let responseCode: Int
    let results: [ResultTrueFalse]
    
    static var quizzes = [Result]()
    static var quiz = [Quiz]()

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }

    init(responseCode: Int, results: [ResultTrueFalse]) {
        self.responseCode = responseCode
        self.results = results
    }
}

// MARK: - Result
class ResultTrueFalse: Codable {
    let category, type, difficulty, question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }

    init(category: String, type: String, difficulty: String, question: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.category = category
        self.type = type
        self.difficulty = difficulty
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
}
