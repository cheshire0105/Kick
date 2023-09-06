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
    
    private let signUpLabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.text = "Sign UP"
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
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
        return textField
    }()
    
    private let makingPasswordTextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.placeholder = "New Password"
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
        textField.placeholder = "Check Password"
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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .cyan
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        return button
    }()
    
    private let cancelButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("CANCEL", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.systemPink
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        return button
    }()
    
    //유효성 라벨
    private let idCondition = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        //label.text = "asdasdfasdfasdf"
        //label.isHidden = true
        return label
    }()
    
    private let passwordCondition = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        //label.text = "asdasdfasdfasdf"
        //label.isHidden = true
        return label
    }()
    
    private let checkingPasswordCondition = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        //label.text = "asdasdfasdfasdf"
        //label.isHidden = true
        return label
    }()
    
    
    /*------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureMakingAccountInputView()
        configureLayout()
        buttonClick()
    }
    
    /*------------------------------------*/
    
    func configureMakingAccountInputView () {
        
        for subview in [ makingIdTextField, makingPasswordTextField, checkingPasswordTextField, okButton, cancelButton, checkingPasswordCondition ] {
            makingAccountInputView.addSubview(subview)
        }
    }
    
    func configureLayout () {
        
        for subview in [
            logoImageView, signUpLabel, makingIdTextField, makingPasswordTextField, checkingPasswordTextField, okButton, cancelButton, idCondition, passwordCondition, checkingPasswordCondition ] {
            view.addSubview(subview)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-150)
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).inset(30)
            make.bottom.equalTo(makingIdTextField.snp.top).offset(-50)
            make.leading.equalToSuperview().offset(150)
            make.trailing.equalToSuperview().offset(-150)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        makingIdTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(40)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        makingPasswordTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(110)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        checkingPasswordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(180)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        
        okButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(250)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(300)
            make.width.equalTo(300)
            make.height.equalTo(40)
            
        }
        
        idCondition.snp.makeConstraints { make in
            make.top.equalTo(makingIdTextField.snp.bottom).offset(5)
            make.leading.equalTo(makingIdTextField).offset(20)
            
        }
        passwordCondition.snp.makeConstraints { make in
            make.top.equalTo(makingPasswordTextField.snp.bottom).offset(5)
            make.leading.equalTo(makingPasswordTextField).offset(20)
        }
        checkingPasswordCondition.snp.makeConstraints { make in
            make.top.equalTo(checkingPasswordTextField.snp.bottom).offset(5)
            make.leading.equalTo(checkingPasswordTextField).offset(20)
            
        }
    }
    
    
    
    /*------버튼-----*/
    
    @objc func okButtonClick() {
        
        if let newUserId = makingIdTextField.text, !newUserId.isEmpty,
           let newUserPassword = makingPasswordTextField.text, !newUserPassword.isEmpty,
           let confirmPassword = checkingPasswordTextField.text, !confirmPassword.isEmpty {
            
            var userArray: [User] = []
            var newUser = User()
            newUser.id = newUserId
            newUser.password = newUserPassword
            
            if newUserId.isEmpty == false && newUserPassword.isEmpty == false && newUserPassword == confirmPassword {
                newUser.id?.append(newUserId)
                newUser.password?.append(newUserPassword)
                userArray.append(newUser)
                print("새 계정이 만들어졌습니다.")
                print("-----------------------")
                print("새 계정 정보 - 아이디 : \(newUserId)  //  비밀번호 : \(newUserPassword)")
                print("-----------------------")
                
                let userIdList = userArray.compactMap { $0.id }
                print("유저 목록 : \(userIdList)")
            }
            else {
                print("비밀번호가 일치하지 않습니다.")
                return
            }
            
            let makeAccountAlert = UIAlertController(title: "가입완료", message: "로그인해주세요.", preferredStyle: .alert)
            let alertOk = UIAlertAction(title: "OK", style: .default) { (textField) in
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    loginViewController.modalPresentationStyle = .fullScreen
                    self.present(loginViewController, animated: false) {
                        self.navigationController?.viewControllers.remove(at: 0)
                    }
                }
            }
            makeAccountAlert.addAction(alertOk)
            self.present(makeAccountAlert, animated: true, completion: nil)
        } else {
            print("모든 필드를 작성해야 합니다.")
        }
    }
    
    @objc func cancelButtonClick() {
        print("가입을 포기")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func idTextFieldTyped(_ sender: UITextField) {
        idCondition.isHidden = false
        let userWord = makingIdTextField.text?.lowercased()
        makingIdTextField.text = userWord
        
        let minCount = 6
        let maxCount = 12
        let count = userWord!.count
        
        switch count {
            
        case 0:
            idCondition.text = " id는 필수입력 정보입니다."
            idCondition.textColor = .red
            
        case 1..<minCount:
            idCondition.text = " id는 6자 이상이어야합니다."
            idCondition.textColor = .red
            
        case minCount...maxCount:
            let idPattern = "^[a-z0-9-_]{\(minCount),\(maxCount)}$"
            let isValidPattern = (userWord!.range(of: idPattern, options: .regularExpression) != nil)
            if isValidPattern {
                idCondition.text = " 조건에 맞는 id"
                idCondition.isHidden = true
            }
            else {
                idCondition.text = " 소문자와 숫자만 사용할수있습니다"
                idCondition.textColor = .red
            }
        default :
            idCondition.text = " id는 6 ~ 12자 사이"
            idCondition.textColor = .red
        }
    }
    
    @objc func passWordTextFieldTyped(_ sender: UITextField) {
        
        passwordCondition.isHidden = false
        
        let minCount = 8
        let maxCount = 16
        let count = makingPasswordTextField.text!.count
        
        switch count {
            
        case 0:
            passwordCondition.text = " 비밀번호는 필수입력정보 입니다"
            passwordCondition.textColor = .red
            
        case 1..<minCount:
            passwordCondition.text = " 비밀번호는 8자 이상"
            passwordCondition.textColor = .red
            
        case minCount...maxCount:
            let passwordPattern = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[\p{P}\p{S}])[A-Za-z\d\p{P}\p{S}]{\#(minCount),\#(maxCount)}$"#
            let isValidPattern = (makingPasswordTextField.text!.range(of: passwordPattern, options: .regularExpression) != nil)
            
            if isValidPattern {
                passwordCondition.text = " 조건에 맞음"
                passwordCondition.isHidden = true
            }
            else {
                passwordCondition.text = " 대문자, 특수문자를 포함해야합니다."
                passwordCondition.textColor = .red
            }
            
        default:
            passwordCondition.text = " pw는 8 ~ 16자 사이"
            idCondition.textColor = .red
            
        }
    }
    
    @objc func checkingPasswordTyped(_ sender: UITextField) {
        
        checkingPasswordCondition.isHidden = false
        
        let checkAgainPassword = checkingPasswordTextField.text
        let checkPassword = makingPasswordTextField.text
        
        if checkAgainPassword == checkPassword {
            
            checkingPasswordCondition.text = "비밀번호 확인"
            checkingPasswordCondition.textColor = .green
        }
        else {
            checkingPasswordCondition.text = "다시한번 확인하세요"
            checkingPasswordCondition.textColor = .red
        }
        
    }
    
    
    
    
    
    
    
    func buttonClick () {
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(okButtonClick), for: .touchUpInside)
        
        makingIdTextField.addTarget(self, action: #selector(idTextFieldTyped(_:)), for: .editingChanged)
        makingPasswordTextField.addTarget(self, action: #selector(passWordTextFieldTyped(_:)), for: .editingChanged)
        checkingPasswordTextField.addTarget(self, action: #selector(checkingPasswordTyped(_:)), for: .editingChanged)
    }
    
    
}
