//
//  MapViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import UIKit
import SnapKit
import NMapsMap

class MapViewController: UIViewController, NMFMapViewOptionDelegate  {
    
    // Properties
    private let registerButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "rectangle.fill"), for: .normal)
        button.addTarget(MapViewController.self, action: #selector(registerButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let mapView = NMFMapView()
    private let naverMapView = NMFNaverMapView()
    
    private let positionButton = {
        let button = NMFLocationButton()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMap()
        configureLayout()
    }
    
    func configureMap() {

    }
    
    func configureLayout() {
        view.addSubview(mapView)
        view.addSubview(registerButton)
        
        positionButton.mapView = naverMapView.mapView
        view.addSubview(positionButton)
        
        positionButton.snp.makeConstraints { make in
            make.trailing.equalTo(registerButton.snp.trailing).offset(-10)
            make.bottom.equalTo(registerButton.snp.top).offset(-10)
            
        }
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints{ make in
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
        }
    }
    
    @objc func registerButtonAction() {
        let storyboard = UIStoryboard(name: "KickBoardRegister", bundle: nil)
        
        if let kickBoardRegisterVC = storyboard.instantiateViewController(withIdentifier: "KickBoardRegisterViewController") as? KickBoardRegisterViewController {
            self.present(kickBoardRegisterVC, animated: true, completion: nil)
        }
    }
    
}


extension MapViewController: NMFAuthManagerDelegate {
    /* MNFAuthManagerDelegate, 인증 실패하면 Error 반환 */
    func authorized(_ state: NMFAuthState, error: Error?) {
        print("error: ", error!)
    }
}
