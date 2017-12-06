//
//  ViewControllerCategories.swift
//  ProjectInterview
//
//  Created by Elena Goroshko on 12/4/17.
//  Copyright © 2017 Elena Goroshko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewControllerCategories: UIViewController {
    
    @IBOutlet private weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        
     //   NotificationCenter.default.addObserver(self, selector: #selector(responseCompled(_:)), name: didComplete , object: nil)
        
        Alamofire.request("https://qriusity.com/v1/categories/").responseJSON { response in
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
// MARK: - extension UITableView
extension ViewControllerCategories: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.countOfCategory()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        debugPrint("1")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryOfQuestionsCell") as? CategoryOfQuestionsCell else {
            debugPrint("Error: Cell does't exist")
            return CategoryOfQuestionsCell()
        }
        guard let categ = DataManager.instance.categories(index: indexPath.row) else { return CategoryOfQuestionsCell() }
        debugPrint(categ)
        cell.update(categoryOfQuestions: categ.name)
        return cell
    }
}
    //MARK: - Alamofire notificatin
extension ViewControllerCategories {
    @objc func responseCompled(_ notification: Notification) {
        self.tabelView.reloadData()
    }
}
