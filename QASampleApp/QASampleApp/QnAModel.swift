//
//  QnAModel.swift
//  QASampleApp
//
//  Created by krishnika agarwal on 17/12/16.
//  Copyright © 2016 krishnika agarwal. All rights reserved.
//

import Foundation




struct UserDetails {
    var profilePic: String?
    var name: String?
    
}

class Answer {
    var user: UserDetails?
    var answerBody: String?
    
    init?(json: JSON) {
        answerBody = json["answer"]["body"].string
        user = UserDetails(profilePic: json["user"]["profilepic"].string, name: json["user"]["name"].string)
    }
}

class Post {
    var postBody: String?
    var kidAge: Double?
    var answers: [Answer] = []
    
    init?(json: JSON) {
        
        postBody = json["shortenedText"].string
        kidAge = json["kidAgeGroup"].double
        
        for answerItems in json["answers"].array! {
            if let answer = Answer(json: answerItems) {
                answers.append(answer)
            }
        }
    }
}

