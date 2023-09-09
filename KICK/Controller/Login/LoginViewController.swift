//
//  LoginViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

// MARK: - KICK APPLICATION

import Foundation
import SnapKit
import UIKit

class LoginViewController: UIViewController {
    // MARK: - private
    
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
    
    private let idTextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.placeholder = "Your ID"
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
        textField.tintColor = .magenta
        textField.clearButtonMode = .whileEditing
        textField.clearsOnBeginEditing = true
        return textField
    }()
    
    private let passwordTextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.placeholder = "Your PW"
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
        textField.tintColor = .magenta
        textField.clearButtonMode = .whileEditing
        textField.clearsOnBeginEditing = true
        textField.isSecureTextEntry = true
        
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
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureAccountInputView()
        configureLayout()
        buttonClick()
    }
    
    override func viewDidAppear(_ animated: Bool) {}
    
    // MARK: - layout
    
    func configureAccountInputView() {
        for subview in [idTextField, passwordTextField, idLabel, passwordLabel] {
            accountInputView.addSubview(subview)
        }
        
        idTextField.snp.makeConstraints { make in
            make.leading.equalTo(accountInputView.snp.leading).inset(40)
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
    
    func configureLayout() {
        for subview in [logoImageView, logInButton, accountInputView, signUpButton, makingAccountLabel] {
            view.addSubview(subview)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
        }
        
        accountInputView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(0)
            make.width.equalTo(250)
            make.height.equalTo(200)
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
    
    // MARK: - func click event
    
    @objc func idTextFieldTyped(_ sender: UITextField) {
        let userWord = idTextField.text?.lowercased()
        idTextField.text = userWord
    }
    
    @objc func logInButtonClick() {
        print("로그인 버튼 클릭됨")
        if let userIdForLogin = idTextField.text, !userIdForLogin.isEmpty,
           let userPasswordForLogin = passwordTextField.text, !userPasswordForLogin.isEmpty
        {
            let userManager = UserManager.shared
            if let user = userManager.getUser(id: userIdForLogin) {
                if user.password == userPasswordForLogin && user.id == userIdForLogin {
                    print("로그인 성공")
                    let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
                    if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
                        tabBarController.modalPresentationStyle = .fullScreen
                        present(tabBarController, animated: true) {
                            self.navigationController?.viewControllers.remove(at: 0)
                        }
                      
                    } else {
                        print("로그인 실패")
                       showAlertWhenLoginFails(message: "ID 또는 비밀번호가 일치하지 않습니다.")
                    }
                } else {
                    print("비밀번호 틀림.")
                    showAlertWhenLoginFails(message: "비밀번호 틀림.")
                }
            } else {
                print("ID와 비밀번호를 다시 확인해주세요.")
                showAlertWhenLoginFails(message: "ID와 비밀번호를 다시 확인해주세요.")
            }
        } else {
            print("뭐라도 입력하세요.")
            showAlertWhenLoginFails(message: "뭐라도 입력은 해보세요.")
        }
    }
    
    @objc func signUpButtonClick() {
        print("회원가입 페이지로 가즈아")
        let signUpViewController = SignUpViewController()
        signUpViewController.modalPresentationStyle = .fullScreen
        present(signUpViewController, animated: true, completion: nil)
    }
    
    func buttonClick() {
        logInButton.addTarget(self, action: #selector(logInButtonClick), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonClick), for: .touchUpInside)
        idTextField.addTarget(self, action: #selector(idTextFieldTyped(_:)), for: .editingChanged)
    }
    
    func showAlertWhenLoginFails (message: String) {
        let alertController = UIAlertController(title: "로그인 실패", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "돌아가기", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
