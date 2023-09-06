//
//  LoginViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController  {
    
    private let accountInputView = UIView()
    
    private let logoImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let idLabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.text = "ID"
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let passwordLabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.text = "PASSWORD"
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let makingAccountLabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.text = "Dont't have an account?"
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let idTextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.placeholder = "Your ID"
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
        textField.tintColor = .red
        textField.isEnabled = true
        return textField
    }()
    
    
    
    private let passwordTextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.placeholder = "Your PW"
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    private let logInButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Sign IN", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .cyan
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        return button
    }()
    
    private let signUpButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Sign UP", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    /*--------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureAccountInputView()
        configureLayout()
        buttonClick()

    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    /*--------------------------------------------------------*/
    func configureAccountInputView () {
        
        for subview in [ idTextField, passwordTextField, idLabel, passwordLabel ] {
            accountInputView.addSubview(subview)
        }
        
        idTextField.snp.makeConstraints { make in
            make.leading.equalTo(40)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        idLabel.snp.makeConstraints { make in
            make.bottom.equalTo(idTextField.snp.top).offset(-1)
            make.leading.equalTo(idTextField)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(40)
            make.top.equalTo(idTextField.snp.bottom).offset(30)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField)
            make.bottom.equalTo(passwordTextField.snp.top).offset(-1)
        }
    }
    
    func configureLayout () {
        
        for subview in [logoImageView, logInButton, accountInputView, signUpButton, makingAccountLabel] {
            view.addSubview(subview)
        }
        
        logoImageView.snp.makeConstraints{ make in
            make.height.equalTo(300)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
        }
        
        accountInputView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(0)
            make.width.equalTo(250)
            
        }
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.leading.equalTo(accountInputView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(110)
            make.width.equalTo(110)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(45)
            make.leading.equalTo(makingAccountLabel.snp.trailing).offset(10)
            
        }
        
        makingAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(100)
            
        }
       
    }
    
    /*------버튼-----*/
    @objc func logInButtonClick() {
        print("로그인 버튼 클릭됨")
        
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true) {
                self.navigationController?.viewControllers.remove(at: 0)
            }
        }
    }
    
    @objc func signUpButtonClick() {
        print("회원가입 페이지로 가즈아")
        let signUpViewController = SignUpViewController()
        signUpViewController.modalPresentationStyle = .fullScreen
        present(signUpViewController, animated: true, completion: nil)
    }
   
    func buttonClick () {
        logInButton.addTarget(self, action: #selector(logInButtonClick), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonClick), for: .touchUpInside)
        
    }
}


