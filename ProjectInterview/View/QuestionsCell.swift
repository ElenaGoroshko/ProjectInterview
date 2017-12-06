//
//  QuestionsCell.swift
//  ProjectInterview
//
//  Created by Elena Goroshko on 12/6/17.
//  Copyright © 2017 Elena Goroshko. All rights reserved.
//

import UIKit

class QuestionsCell: UITableViewCell {

    @IBOutlet private weak var ibLabelQuestion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func update(question: String) {
        self.ibLabelQuestion.text = question
    }
}
