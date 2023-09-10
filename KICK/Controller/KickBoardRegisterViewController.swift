//
//  KickBoardRegisterViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import UIKit
import AVFoundation

class KickBoardRegisterViewController: UIViewController {
    
    var selectedKickboardID: String? // 킥보드 저장 프로퍼티 추가
    
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
        // fetchAndDisplayKickboardInfo()
        
        // 더미 이미지를 탭하면 더미 데이터를 생성하고 저장, 그리고 레이블에 표시
        let dummyKickboardID = selectedKickboardID // 더미 킥보드 ID
        rentedKickboardID = dummyKickboardID
        
        // 더미 킥보드 객체 생성
        let dummyKickboard = Kickboard(uniqueID: dummyKickboardID ?? "로딩 실패", isRented: false, batteryLevel: 100)
        
        // 더미 킥보드 저장
        KickboardManager.shared.saveKickboard(kickboard: dummyKickboard)
        
        updateRentReturnButton(isRented: dummyKickboard.isRented)
        updateKickboardInfoLabels(kickboardID: dummyKickboard.uniqueID, returnInfo: "Available for Rent", batteryInfo: dummyKickboard.batteryLevel)
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
        kickboardInfoLabel.text = "킥보드 아이디: \(kickboardID)"
        returnInfoLabel.text = "대여 여부: \(returnInfo)"
        batteryInfoLabel.text = "배터리 잔량: \(batteryInfo)%"
    }
    
    
    
    @IBAction func rentButton(_ sender: UIButton) {
        guard let kickboardID = rentedKickboardID, let kickboard = KickboardManager.shared.getKickboard(uniqueID: kickboardID) else {
            showAlert(title: "Error", message: "킥보드의 QR을 인식해주세요.")
            return
        }
        
        let alertController = UIAlertController(title: "대여 확인", message: "대여하시겠습니까?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "예", style: .default, handler: { [weak self] _ in
            var updatedKickboard = kickboard
            updatedKickboard.isRented.toggle()
            
            // 킥보드의 대여 상태를 업데이트합니다.
            KickboardManager.shared.saveKickboard(kickboard: updatedKickboard)
            
            self?.updateRentReturnButton(isRented: updatedKickboard.isRented)
            
            // 레이블 업데이트 (더미 데이터로 설정됨)
            let batteryLevel = 100
            self?.updateKickboardInfoLabels(kickboardID: updatedKickboard.uniqueID, returnInfo: "Sample Return Info", batteryInfo: batteryLevel)
            
            // 대여 상태 변경 알림을 보냅니다.
            NotificationCenter.default.post(name: NSNotification.Name("KickboardRentalStatusChanged"), object: updatedKickboard.isRented)
            
            // MypageViewController로 이동
            self?.navigateToMypage()
        }))
        alertController.addAction(UIAlertAction(title: "아니오", style: .cancel))
        present(alertController, animated: true)
    }

    
    
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    
    func navigateToMypage() {
        let storyboard = UIStoryboard(name: "Mypage", bundle: nil)  // 여기서 "YourStoryboardName"을 대상 스토리보드의 이름으로 교체하세요 (확장자 없이).
        if let mypageViewController = storyboard.instantiateViewController(withIdentifier: "MypageViewController") as? MypageViewController {
            mypageViewController.modalPresentationStyle = .fullScreen
            present(mypageViewController, animated: true, completion: nil)
        }
    }
    
}

// MARK: - 킥보드 불러오는 함수
extension KickBoardRegisterViewController {
    
    func fetchAndDisplayKickboardInfo(kickboardID: String?) {
        if let kickboardID = selectedKickboardID, let kickboard = KickboardManager.shared.getKickboard(uniqueID: kickboardID) {
            // 킥보드 정보로 레이블 업데이트
            updateKickboardInfoLabels(kickboard: kickboard)
        } else {
            // 더미 데이터로 레이블 업데이트
            displayDummyKickboardInfo()
        }
    }
    
    func updateKickboardInfoLabels(kickboard: Kickboard) {
        kickboardInfoLabel.text = "킥보드 아이디: \(kickboard.uniqueID)"
        returnInfoLabel.text = "대여 여부: \(kickboard.isRented ? "Rented" : "Available for Rent")"
        batteryInfoLabel.text = "배터리 잔량: \(kickboard.batteryLevel)%"
    }
    
    func displayDummyKickboardInfo() {
        print(selectedKickboardID)
        let dummyKickboard = Kickboard(uniqueID: selectedKickboardID ?? "킥보드 인식 실패", isRented: false, batteryLevel: 100) // 더미 킥보드 객체 생성
        updateKickboardInfoLabels(kickboard: dummyKickboard)
    }
}
