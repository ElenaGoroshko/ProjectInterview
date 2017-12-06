//
//  DataManager.swift
//  ProjectInterview
//
//  Created by Elena Goroshko on 12/5/17.
//  Copyright © 2017 Elena Goroshko. All rights reserved.
//

import Foundation

final class DataManager {
    static let instance = DataManager()
    private var allCategories: [CategoryOfQuestions]

    private init() {
        allCategories = []
    }

    func addCategoryOfQuestions(_ category: CategoryOfQuestions) {
        allCategories.append(category)
    }
    func categories(index: Int) -> CategoryOfQuestions? {
        let i = index
        if i >= 0, i < allCategories.count {
            let c = allCategories[i] 
            return c
        } else {
            return nil
        }
    }
    func countOfCategory() -> Int {
        return allCategories.count
    }
}
