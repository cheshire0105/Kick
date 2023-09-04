//
//  MypageViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import UIKit

class MypageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func backToMypage(_ sender: Any) {
        if self.presentingViewController != nil {
             self.dismiss(animated: true)
           } else if self.navigationController != nil {
             self.navigationController?.popViewController(animated: true)
           }
    }
    
}
