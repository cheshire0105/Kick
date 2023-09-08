//
//  MypageViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//
import Foundation
import UIKit

class MypageViewController: UIViewController {
    
    var user: User?
    
    let defaults = UserDefaults.standard
    let userData = UserManager.shared
        
    @IBOutlet weak var displayedImage: UIImageView!
    @IBOutlet weak var displayedName: UILabel!
    @IBOutlet weak var displayedID: UILabel!
    @IBOutlet weak var displayedContact: UILabel!
    @IBOutlet weak var displayedLevel: UILabel!
    @IBOutlet weak var displayedCredit: UILabel!
    @IBOutlet weak var displayedLicense: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = userData.getUser(id: "사용자 ID")
        
        if let user = user {
            displayedID.text = user.id
            displayedName.text = user.userName
            displayedContact.text = user.userContact
            displayedCredit.text = user.userCredit
            displayedLicense.text = user.userLicense
        }
        
        setupUserData()
//        activateOccupyMode()
    }
    
    // 1. 등록된 사용자의 정보를 레이블에 표시 ⭐️⭐️⭐️⭐️⭐️
    func setupUserData() -> User {
        // 사용자가 로그인을 한 상태라면
        return User(id: "사용자 ID", userName: "사용자 이름", userContact: "사용자 연락처", userCredit: "등록된 카드번호", userLicense: "운전면허 등록번호")
    }
    
        // 3. 킥보드 대여중일 경우, 이용중 버튼 컬러가 활성화 / 이용중이 아닐시 비활성화 ⭐️⭐️⭐️
//    func activateOccupyMode() {
//
//    }
        // 4. 이용내역 표시하기 ⭐️⭐️⭐️⭐️⭐️
        // 5. 로그아웃 버튼 클릭시 로그인 상태 해제 및 로그인 페이지로 이동
    @IBAction func letLogoutButton(_ sender: Any) {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
    }
    
    }
