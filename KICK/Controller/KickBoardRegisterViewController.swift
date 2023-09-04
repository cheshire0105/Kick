//
//  KickBoardRegisterViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import UIKit
import AVFoundation

class KickBoardRegisterViewController: UIViewController {
    
    // 카메라 뷰
    @IBOutlet weak var cameraView: UIView!
    
    // 대여/반납 버튼
    @IBOutlet weak var rentReturnButton: UIButton!
    @IBOutlet weak var kickboardInfoLabel: UILabel!
    @IBOutlet weak var returnInfoLabel: UILabel!
    @IBOutlet weak var batteryInfoLabel: UILabel!
    
    // 현재 대여 중인 킥보드의 Unique ID
    var rentedKickboardID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDummyImageView()
    }
    
    func setupDummyImageView() {
        // 더미 이미지 설정 및 탭 제스처 추가
        let dummyImageView = UIImageView(image: UIImage(named: "dummy_image"))
        dummyImageView.frame = cameraView.bounds
        dummyImageView.contentMode = .scaleAspectFit
        dummyImageView.isUserInteractionEnabled = true
        dummyImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDummyImageTap)))
        
        cameraView.addSubview(dummyImageView)
    }

    
    @objc func handleDummyImageTap() {
        // 더미 이미지를 탭하면 더미 데이터를 가져와서 레이블에 표시
        let dummyKickboardID = "12345" // 더미 킥보드 ID
        rentedKickboardID = dummyKickboardID
        
        updateRentReturnButton(isRented: false)
        updateKickboardInfoLabels(kickboardID: dummyKickboardID, returnInfo: "Sample Return Info", batteryInfo: 100) // 여기에서 배터리 정보를 Int로 전달
    }
    
    func updateRentReturnButton(isRented: Bool) {
        if isRented {
            rentReturnButton.setTitle("Return", for: .normal)
        } else {
            rentReturnButton.setTitle("Rent", for: .normal)
        }
    }
    
    func updateKickboardInfoLabels(kickboardID: String, returnInfo: String, batteryInfo: Int) {
        // 더미 데이터로 레이블 업데이트
        kickboardInfoLabel.text = "Kickboard ID: \(kickboardID)"
        returnInfoLabel.text = "Return Info: \(returnInfo)"
        batteryInfoLabel.text = "Battery Info: \(batteryInfo)%"
    }

    
    @IBAction func rentReturnButtonTapped(_ sender: UIButton) {
        guard let kickboardID = rentedKickboardID else {
            showAlert(title: "Error", message: "Please scan a QR code first")
            return
        }
        
        if var kickboard = UserDefaultsManager.shared.getKickboard(uniqueID: kickboardID) {
            kickboard.isRented.toggle()
            UserDefaultsManager.shared.saveKickboard(kickboard: kickboard)
            updateRentReturnButton(isRented: kickboard.isRented)
            
            // 이 부분에서 실제 배터리 수준 정보를 가져와야 함. 현재는 더미 값으로 설정됨
            let batteryLevel = 100
            updateKickboardInfoLabels(kickboardID: kickboard.uniqueID, returnInfo: "Sample Return Info", batteryInfo: batteryLevel)
        } else {
            showAlert(title: "Error", message: "Kickboard not found")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
