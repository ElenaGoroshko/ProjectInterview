//
//  OptionsViewController.swift
//  ProjectInterview
//
//  Created by Elena Goroshko on 12/13/17.
//  Copyright © 2017 Elena Goroshko. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    var question: Question?

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var ibLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        ibLabel.text = question?.question

        guard let count = question?.options.count else {return}
        for i in 0...(count - 1) {
            let btn: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 160, height: 50 ))
            btn.backgroundColor = UIColor.lightGray
            guard let title = question?.options[i] else {return}
            debugPrint(question?.options[i])
            btn.setTitle(title, for: UIControlState.normal)
            btn.addTarget(self, action: #selector(self.buttonAction(_:)),
                          for: UIControlEvents.touchUpInside)
            self.stackView.addArrangedSubview(btn as UIView)
        }
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
                //var btnsendtag: UIButton = sender
        debugPrint("+++", sender.currentTitle ?? "---")
        
    }
    
}
