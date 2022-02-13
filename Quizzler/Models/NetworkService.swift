//
//  NetworkService.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-02-12.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import Foundation

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
                
            } catch let err{
                print(err)
            }
            //print(String(data: data, encoding: .utf8)!)
            print("secret key ")
            print(NetworkService.secrectKey[0].token)
            
            
        }
        task.resume()
    }
    
    func loadQuiz(difficulty: String, category: Int, completionHandler: @escaping(Bool?)->Void){

        var request = URLRequest(url: URL(string: "\(triviaURL)\(NetworkService.secrectKey[0].token)&category=\(category)&difficulty=\(difficulty)&type=multiple")!,timeoutInterval: Double.infinity)
//        request.addValue("PHPSESSID=ec489967efc2bea9540a32b2fbd8eb22", forHTTPHeaderField: "Cookie")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
            
            do {
                let json = try JSONDecoder().decode(Result.self, from: data)
                Quiz.quizzes.append(Result(category: json.category, type: json.type, difficulty: json.difficulty , question: json.question, correctAnswer: json.correctAnswer, incorrectAnswers: json.incorrectAnswers))
                dump(Quiz.quizzes)
                
            } catch let err{
                print(err)
            }

        }

        task.resume()
    }
    
    

}
