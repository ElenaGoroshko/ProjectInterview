//
//  CategoryOfQuestions.swift
//  ProjectInterview
//
//  Created by Elena Goroshko on 12/5/17.
//  Copyright © 2017 Elena Goroshko. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CategoryOfQuestions {
    let id: Int
    let name: String
    //   let parent_category: String
    //   let
}

// MARK: extension
extension CategoryOfQuestions {
    init? (json: JSON) {
        guard let id = json["id"].int,
            let name = json["name"].string else {
                return nil
        }
        self.id = id
        self.name = name
    }
}
