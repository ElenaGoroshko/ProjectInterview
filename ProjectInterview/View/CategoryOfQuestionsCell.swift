//
//  CategoryOfQuestionsCell.swift
//  ProjectInterview
//
//  Created by Elena Goroshko on 12/5/17.
//  Copyright © 2017 Elena Goroshko. All rights reserved.
//

import UIKit

class CategoryOfQuestionsCell: UITableViewCell {

    @IBOutlet private weak var ibLabelCategory: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func update(categoryOfQuestions: String) {
        ibLabelCategory.text = categoryOfQuestions
    }
}
