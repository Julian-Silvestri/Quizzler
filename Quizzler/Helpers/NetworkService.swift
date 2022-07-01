//
//  NetworkService.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-12.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import Foundation
import CoreMedia

class NetworkService{
    //Category Numbers
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
    
    public static let shared: NetworkService = NetworkService()
    
    var triviaURL = "https://opentdb.com/api.php?amount=20&token="
    var triviaCountURL = "https://opentdb.com/api_count.php?category="
    static var secrectKey = [Secret]()
    
    func grabToken(completionHandler: @escaping(Bool?)->Void){
        
        var request = URLRequest(url: URL(string: "https://opentdb.com/api_token.php?command=request")!,timeoutInterval: Double.infinity)
        request.addValue("PHPSESSID=ec489967efc2bea9540a32b2fbd8eb22", forHTTPHeaderField: "Cookie")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(Secret.self, from: data)
                NetworkService.secrectKey.append(Secret(responseCode: json.responseCode, responseMessage: json.responseMessage, token: json.token))
                completionHandler(true)
            } catch let err{
                print(err)
                completionHandler(false)
            }
            //print(String(data: data, encoding: .utf8)!)
            print("secret key ")
            print(NetworkService.secrectKey[0].token)
        }
        task.resume()
    }
    
    func resetToken(completionHandler: @escaping(Bool?)->Void){
        //empty the secret key
        NetworkService.secrectKey.removeAll()
        
        var request = URLRequest(url: URL(string: "https://opentdb.com/api_token.php?command=reset&token=\(NetworkService.secrectKey[0].token)")!,timeoutInterval: Double.infinity)
        request.addValue("PHPSESSID=ec489967efc2bea9540a32b2fbd8eb22", forHTTPHeaderField: "Cookie")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(Secret.self, from: data)
                NetworkService.secrectKey.append(Secret(responseCode: json.responseCode, responseMessage: json.responseMessage, token: json.token))
                completionHandler(true)
            } catch let err{
                print(err)
                completionHandler(false)
            }
            //print(String(data: data, encoding: .utf8)!)
            print("secret key ")
            print(NetworkService.secrectKey[0].token)
        }
        task.resume()
    }
    
    func loadQuiz(type: String, difficulty: String, category: Int, completionHandler: @escaping(Bool?)->Void){

        var request = URLRequest(url: URL(string: "\(triviaURL)\(NetworkService.secrectKey[0].token)&category=\(category)&difficulty=\(difficulty)&type=\(type)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let json = try JSONDecoder().decode(Quiz.self, from: data)
                Quiz.quiz.append(Quiz(responseCode: json.responseCode, results: json.results))
                for values in Quiz.quiz{
                    for data in values.results {
                        Quiz.quizzes.append(Result(category: data.category, type: data.type, difficulty: data.difficulty, question: data.question, correctAnswer: data.correctAnswer, incorrectAnswers: data.incorrectAnswers))
                    }
                }
                completionHandler(true)
            } catch let err{
                print(err.localizedDescription)
                print("error ")
                self.resetToken(completionHandler: {success in
                    if success == true {
                        print("token has been reset")
                    } else{
                        print("failure resetting token")
                    }
                })
            }
        }
        task.resume()
    }
    
//    "https://opentdb.com/api.php?amount=20&token="
//https://opentdb.com/api_count.php?category=13
    func quizCount(category: Int,completionHandler: @escaping(Bool)->Void){
        var request = URLRequest(url: URL(string: "\(triviaCountURL)\(category)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let json = try JSONDecoder().decode(QuizCount.self, from: data)
                var unFilteredData = [QuizCount]()
                unFilteredData.append(QuizCount(categoryID: json.categoryID, categoryQuestionCount: json.categoryQuestionCount))
                QuizCount.quizCount.append(QuizCount(categoryID: json.categoryID, categoryQuestionCount: json.categoryQuestionCount))

                print("COUNT oF QUIZZ -> ***\(QuizCount.quizCount.count)")
                completionHandler(true)
            } catch let err{
                print(String(describing: err))
                print("error ")
//                self.resetToken(completionHandler: {success in
//                    if success == true {
//                        print("token has been reset")
//                    } else{
//                        print("failure resetting token")
//                    }
//                })
            }
        }
        task.resume()
    }

    
}
