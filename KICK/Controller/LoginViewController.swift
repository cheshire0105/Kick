//
//  LoginViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import UIKit
import SnapKit


class LoginViewController: UIViewController  {
    
    @IBAction func testButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true) {
                self.navigationController?.viewControllers.remove(at: 0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .clear
        
        idLabel()
        //idTextField()
        pwLabel()
        logInButton()
        
    }
  
}

extension LoginViewController : UITextFieldDelegate {
    
    func idLabel () {
        let label = UILabel()
        label.text = "I D"
        label.frame = CGRect(x: 50, y: 400, width: 50, height: 30)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        self.view.addSubview(label)
    }
    
    func pwLabel () {
        let label = UILabel()
        label.text = "P W"
        label.frame = CGRect(x: 50, y: 450, width: 50, height: 30)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        self.view.addSubview(label)
    }
    
    //    func idTextField() {
    //        print("idTextField")
    //        let textField = UITextField()
    //        textField.placeholder = "your id"
    //        textField.backgroundColor = UIColor.lightGray
    //        textField.alpha = 1.0
    //        textField.frame(forAlignmentRect: CGRect(x: 50 , y: 100, width: 200, height: 30))
    //        textField.borderStyle = .roundedRect
    //        textField.delegate = self
    //        self.view.addSubview(textField)
    //    }
    
    func logInButton() {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.cyan
        button.frame(forAlignmentRect: CGRect(x: 100, y: 200, width: 50, height: 50))
        view.addSubview(button)
    }
}


