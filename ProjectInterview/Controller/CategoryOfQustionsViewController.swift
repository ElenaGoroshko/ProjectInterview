//
//  CategoryOfQustionsViewController.swift
//  ProjectInterview
//
//  Created by Elena Goroshko on 12/4/17.
//  Copyright © 2017 Elena Goroshko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategoryOfQustionsViewController: UIViewController {
    
    @IBOutlet private weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        getCategory()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? QuestionsViewController, segue.identifier == "SwowQuestions" else {
            debugPrint("Error: It isn't SwowQuestions")
            return
        }
        guard let cell = sender as? CategoryOfQuestionsCell,
              let indexPath = tabelView.indexPath(for: cell) else {
                debugPrint("Error: It isn't CategoryOfQuestionsCell")
                return
        }
        let index = indexPath.row
        guard let category = DataManager.instance.categoryOfQuestions(by: index) else {
            debugPrint("Error: Category isn't exist.")
            return
        }
        destVC.categoryOfQuestions = category

    }
}
// MARK: - extension UITableView
extension CategoryOfQustionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.countOfCategory()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryOfQuestionsCell") as? CategoryOfQuestionsCell else {
            debugPrint("Error: Cell does't exist")
            return CategoryOfQuestionsCell()
        }
        guard let categ = DataManager.instance.categoryOfQuestions(by: indexPath.row) else { return CategoryOfQuestionsCell() }
        debugPrint(categ)
        cell.update(categoryOfQuestions: categ.name)
        return cell
    }
}
// MARK: - Alamofire
extension CategoryOfQustionsViewController {
    
    func getCategory() {
        Alamofire.request("http://qriusity.com/v1/categories/").responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonObj = JSON(value)
                guard let jsonArr = jsonObj.array else { return }
                for jsonObject in jsonArr {
                    guard let categories = CategoryOfQuestions(json: jsonObject) else { continue }
                    DataManager.instance.addCategoryOfQuestions(categories)
                    debugPrint(categories)
                }
                self.tabelView.reloadData()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
