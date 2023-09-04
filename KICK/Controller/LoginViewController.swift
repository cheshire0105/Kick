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
        label.text = "  ID  "
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let idTextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
//        let attributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.gray,
//            .font: UIFont.systemFont(ofSize: 5)
//        ]
//        textField.attributedPlaceholder = NSAttributedString(string: "아이디를 입력해보세요!", attributes: attributes)
        textField.placeholder = "아이디를 입력해보세요!"
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        return textField
    }()
    
    private let passwordLabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.text = "  PW  "
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let passwordTextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.placeholder = "비밀번호를 입력해보세요!"
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        return textField
    }()
    
    private let logInButton = {
        let button = UIButton()
        button.titleLabel?.text = "로그인"
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        return button
    }()
    
    private let signUpButton = {
        let button = UIButton()
        button.titleLabel?.text = "회원가입"
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        return button
    }()
    
    
    @objc func logInButtonTapped() {
        print("버튼")
        // 로그인 버튼이 탭되었을 때 수행할 작업을 이곳에 구현합니다.
        // 예를 들어, 로그인 화면을 표시하거나 로그인 프로세스를 시작할 수 있습니다.
    }
    
    
    
/*--------------------------------------------------------*/
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        
        configureAccountInputView()
        configureLayout()
    }
    
    
    
    
/*--------------------------------------------------------*/
    func configureAccountInputView () {
        
        for subview in [idLabel, idTextField, passwordLabel, passwordTextField, logInButton, signUpButton] {
            accountInputView.addSubview(subview)
        }
        
        idLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalTo(passwordLabel)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(idLabel.snp.bottom).offset(5)
            make.trailing.equalTo(idLabel)
        }
        
        idTextField.snp.makeConstraints { make in
            make.leading.equalTo(idLabel.snp.trailing).offset(5)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(passwordLabel.snp.trailing).offset(5)
            make.top.equalTo(idLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview()
        }
        
//        logInButton.snp.makeConstraints { make in
//            //make.top.equalTo(idLabel).offset(30)
//            //make.bottom.equalTo(passwordLabel).offset(30)
//        }
    }
    
    func configureLayout () {
        
        for subview in [ logoImageView,logInButton, signUpButton, accountInputView ] {
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
            make.leading.equalToSuperview().offset(20)
           
        }
        
        logInButton.snp.makeConstraints { make in
            make.leading.equalTo(accountInputView.snp.trailing).offset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(accountInputView)
            make.bottom.equalTo(signUpButton.snp.top).offset(-20)
        
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(290)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
    
    @IBAction func testButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true) {
                self.navigationController?.viewControllers.remove(at: 0)
            }
        }
    }
}
