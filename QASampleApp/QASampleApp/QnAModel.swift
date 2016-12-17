//
//  QnAModel.swift
//  QASampleApp
//
//  Created by krishnika agarwal on 17/12/16.
//  Copyright © 2016 krishnika agarwal. All rights reserved.
//

import Foundation


class UserDetails {
    var profilePic: String?
    var name: String?
}

class Answer {
    var user: UserDetails?
    var answerBody: String?
}

class Post {
    var postBody: String?
    var kidAge: Double?
    var answers: [Answer] = []
    
    init?(json: JSON) {
        
        postBody = json["shortenedText"].string
        kidAge = json["kidAgeGroup"].double
        
    }
}

