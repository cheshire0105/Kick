//
//  LoginViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
