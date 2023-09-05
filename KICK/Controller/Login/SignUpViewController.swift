//
//  SignUpViewController.swift
//  KICK
//
//  Created by t2023-m0081 on 2023/09/05.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {

    private let makingAccountInputView = UIView()
    
    private let logoImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
    }
    
    private let makingIdLabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.text = "New ID"
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let makingPasswordLabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.text = "new password"
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let checkingPasswordLabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.text = "check password"
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let okButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        return button
    }()
    
    private let cancelButton = {
        let button = UIButton()
        button.setTitle("cancel", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        return button
    }()
    
/*------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        configureMakingAccountInputView()
    }
    
/*------------------------------------*/

    func configureMakingAccountInputView () {

        for subview in [ makingIdLabel, makingPasswordLabel, checkingPasswordLabel, okButton, cancelButton ] {
            makingAccountInputView.addSubview(subview)
        }
    }

    
    
    

}
