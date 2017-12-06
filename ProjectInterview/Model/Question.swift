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
}
extension Question {
    init? (json: JSON) {
        guard let id = json["id"].int,
            let name = json["question"].string else {
                return nil
        }
        self.id = id
        self.question = name
    }
}
