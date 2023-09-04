//
//  MapViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import UIKit

class MapViewController: UIViewController {

    @IBAction func buttonTapped(_ sender: UIButton) {
          
           let storyboard = UIStoryboard(name: "KickBoardRegister", bundle: nil)
         
           if let kickBoardRegisterVC = storyboard.instantiateViewController(withIdentifier: "KickBoardRegisterViewController") as? KickBoardRegisterViewController {
               self.present(kickBoardRegisterVC, animated: true, completion: nil)
           }
       }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    

}
