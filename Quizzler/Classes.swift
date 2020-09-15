//
//  Classes.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-09-14.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import Foundation

class UserOwnedQuizzes:Codable {
    let title: String
    let description: String
    let price: String
    let imageName: String
    
    init(title: String, description: String, price: String, imageName: String){
        self.title = title
        self.description = description
        self.price = price
        self.imageName = imageName
    }
    deinit {
        print("get out of here - User owned quizzes")
    }
}

class QuizzesInStore:Codable {
    let title: String
    let description: String
    let price: String
    let imageName: String
    
    init(title: String, description: String, price: String, imageName: String){
        self.title = title
        self.description = description
        self.price = price
        self.imageName = imageName
    }
    deinit {
        print("get out of here - User owned quizzes")
    }
}
