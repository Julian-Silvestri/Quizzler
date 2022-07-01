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
// MARK: - QuizCount
class QuizCount: Codable {
    let categoryID: Int
    let categoryQuestionCount: CategoryQuestionCount
    
    static var totalQuestions = [CategoryQuestionCount]()
    static var quizCount = [QuizCount]()


    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryQuestionCount = "category_question_count"
    }

    init(categoryID: Int, categoryQuestionCount: CategoryQuestionCount) {
        self.categoryID = categoryID
        self.categoryQuestionCount = categoryQuestionCount
    }
}

// MARK: - CategoryQuestionCount
class CategoryQuestionCount: Codable {
    let totalQuestionCount, totalEasyQuestionCount, totalMediumQuestionCount, totalHardQuestionCount: Int

    enum CodingKeys: String, CodingKey {
        case totalQuestionCount = "total_question_count"
        case totalEasyQuestionCount = "total_easy_question_count"
        case totalMediumQuestionCount = "total_medium_question_count"
        case totalHardQuestionCount = "total_hard_question_count"
    }

    init(totalQuestionCount: Int, totalEasyQuestionCount: Int, totalMediumQuestionCount: Int, totalHardQuestionCount: Int) {
        self.totalQuestionCount = totalQuestionCount
        self.totalEasyQuestionCount = totalEasyQuestionCount
        self.totalMediumQuestionCount = totalMediumQuestionCount
        self.totalHardQuestionCount = totalHardQuestionCount
    }
}

