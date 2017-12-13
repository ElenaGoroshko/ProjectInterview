//
//  Question.swift
//  ProjectInterview
//
//  Created by Elena Goroshko on 12/6/17.
//  Copyright © 2017 Elena Goroshko. All rights reserved.
//

import Foundation
import SwiftyJSON

struct  Question {
    let id: Int
    let question: String
    let answers: Int
    var options: [String]
}
extension Question {
    init? (json: JSON) {
       // debugPrint(json)
        guard let id = json["id"].int,
            let name = json["question"].string,
            let answers = json["answers"].int
        else {
                return nil
        }
        self.id = id
        self.question = name
        self.answers = answers
      
        var options: [String] = []
        for i in 0...10 {
            guard let option = json["option\(i + 1)"].string else {break}
            options.append(option)
        }
        self.options = options
       // debugPrint(self.options)
    }
}
