//
//  QuestionsViewController.swift
//  ProjectInterview
//
//  Created by Elena Goroshko on 12/6/17.
//  Copyright © 2017 Elena Goroshko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class QuestionsViewController: UIViewController {
    
    var categoryOfQuestions: CategoryOfQuestions?

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryOfQuestions?.name ?? "Category doesn't exist"
        tableView.delegate = self
        tableView.dataSource = self
        
        guard let category = categoryOfQuestions else { return }
        getQuestions(category: category)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? OptionsViewController,
                segue.identifier == "ShowOptions",
                let cell = sender as? QuestionsCell,
                let IndexPath = tableView.indexPath(for: cell),
                let categ = categoryOfQuestions else {fatalError("Error")}
        
        destVC.question = DataManager.instance.question(categoryOfQuestions: categ,
                                                        index: IndexPath.row)
        
    }
}
// MARK: - UITableViewDelegate & UITableViewDataSource
extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard  let category = categoryOfQuestions else { return 0 }
        return DataManager.instance.countOfQuestion(categoryOfQuestions: category)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionsCell") as? QuestionsCell else {
            debugPrint("Error: Cell does't exist")
            return QuestionsCell()
        }
        guard let categ = categoryOfQuestions else { return QuestionsCell() }
        guard let quest = DataManager.instance.question(categoryOfQuestions: categ, index: indexPath.row) else {
            return QuestionsCell()
        }
        cell.update(question: quest.question)
        return cell
    }
}

// MARK: - Alamofire
extension QuestionsViewController {
    func getQuestions(category: CategoryOfQuestions) {
        if DataManager.instance.questions(categoryOfQuestions: category) == nil {
           
            let url = "http://qriusity.com/v1/categories/\(category.id)/questions"
            Alamofire.request(url).responseJSON { [weak self] response in
                switch response.result {
                case .success(let value):
                    let jsonObj = JSON(value)
                    guard let jsonArr = jsonObj.array else { return }
                    for jsonObject in jsonArr {
                        guard let question = Question(json: jsonObject) else { continue }
                       // debugPrint(question.options.count)
                        DataManager.instance.addQuestion(categoryOfQuestions: (category), question: question)
                    }
                case .failure(let error):
                    debugPrint(error)
                }
                // debugPrint(DataManager.instance.questions(categoryOfQuestions: (category)))
                self?.tableView.reloadData()
            }
        } else {
            self.tableView.reloadData()
        }
    }
}
