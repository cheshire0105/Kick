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
        
        performSegue(withIdentifier: "TabBarController", sender: self)
        
    }
    
 
    
}
