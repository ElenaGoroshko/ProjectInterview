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
    private var questions: [CategoryOfQuestions: [Question]]

    private init() {
        allCategories = []
        questions = [:]
    }

    func addCategoryOfQuestions(_ category: CategoryOfQuestions) {
        allCategories.append(category)
    }
    func categoryOfQuestions(by index: Int) -> CategoryOfQuestions? {
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
    func addQuestion(categoryOfQuestions: CategoryOfQuestions, question: Question) {
        for categ in allCategories where categ == categoryOfQuestions {
            if questions[categoryOfQuestions] == nil {
                questions[categoryOfQuestions] = [question]
            } else {
                questions[categoryOfQuestions]?.append(question)
            }
        }
    }

    func countOfQuestion(categoryOfQuestions: CategoryOfQuestions) -> Int {
        guard let questions = self.questions[categoryOfQuestions] else { return 0 }
        return questions.count
    }

}
