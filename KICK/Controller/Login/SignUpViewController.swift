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
        imageView.image = UIImage(named: "logoImage")
        return imageView
    }()
    
    private let makingIdTextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.placeholder = "New ID"
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.shadowColor = UIColor.red.cgColor
        textField.layer.shadowOffset = CGSize(width: 10, height: 10)
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 10.0
        return textField
    }()
    
    private let makingPasswordTextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.placeholder = "new password"
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    private let checkingPasswordTextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.placeholder = "check password"
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    private let okButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("OK", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .cyan
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        return button
    }()
    
    private let cancelButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("cancel", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemPink
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        return button
    }()
    
/*------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureMakingAccountInputView()
        configureLayout()
    }
    
/*------------------------------------*/

    func configureMakingAccountInputView () {

        for subview in [ makingIdTextField, makingPasswordTextField, checkingPasswordTextField, okButton, cancelButton ] {
            makingAccountInputView.addSubview(subview)
        }
    }

    func configureLayout () {

        for subview in [
            logoImageView, makingIdTextField, makingPasswordTextField, checkingPasswordTextField, okButton, cancelButton ] {
            view.addSubview(subview)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
                make.width.equalTo(300)
                make.height.equalTo(250)
        }
        
        makingIdTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(130)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        makingPasswordTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(180)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        checkingPasswordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(230)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        
        okButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(300)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(350)
            make.width.equalTo(250)
            make.height.equalTo(40)
            
        }
    }
    
    
    

}
