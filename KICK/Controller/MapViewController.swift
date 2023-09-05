//
//  MapViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import UIKit
import SnapKit

class MapViewController: UIViewController {
    
    // Properties
    private let registerButton = UIButton(type: .system)
    private let mapView = NMFMapView() 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        configureLayout()
        registerButton.setBackgroundImage(UIImage(systemName: "rectangle.fill"), for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
    }
    
    func configureLayout() {
        view.addSubview(registerButton)
        
        registerButton.snp.makeConstraints{ make in
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(10)
        }
    }
    
    @objc func registerButtonAction() {
        let storyboard = UIStoryboard(name: "KickBoardRegister", bundle: nil)
      
        if let kickBoardRegisterVC = storyboard.instantiateViewController(withIdentifier: "KickBoardRegisterViewController") as? KickBoardRegisterViewController {
            self.present(kickBoardRegisterVC, animated: true, completion: nil)
        }
    }
    

    

}
