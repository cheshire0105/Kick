//
//  MypageViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//
import Foundation
import UIKit

class MypageViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let userData = UserManager.shared
    
    var currentUserID: String?
    
    @IBOutlet weak var displayedImage: UIImageView!
    @IBOutlet weak var displayedName: UILabel!
    @IBOutlet weak var displayedID: UILabel!
    @IBOutlet weak var displayedContact: UILabel!
    @IBOutlet weak var displayedLevel: UILabel!
    @IBOutlet weak var displayedCredit: UILabel!
    @IBOutlet weak var displayedLicense: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//            setupUserData()
    }
    
    // 1. 등록된 사용자의 정보를 표시 ⭐️⭐️⭐️⭐️⭐️
//    func setupUserData() {
        //            // userID가 현재 로그인한 유저의 ID와 일치한다면
//        guard let userID = currentUserID else {
//            return dismiss(animated: true, completion: nil)
//        }
        //            if let user = userData.getUser(id: userID) {
        //                // 유저정보를 화면에 표시
        //                let displayedImage = (defaults.array(forKey: "pickedImage") ?? userData.pickedImage)
        //                let displayedName = defaults.array(forKey: "userName") ?? userData.userName
        //                let displayedID = defaults.array(forKey: "id") ?? userData.id
        //                let displayedContact = defaults.array(forKey: "userContact") ?? userData.userContact
        //                let displayedCredit = defaults.array(forKey: "userCredit") ?? userData.userCredit
        //                let displayedLicense = defaults.array(forKey: "userLicense") ?? userData.userLicense
        //            } else {
        //                // 유저 데이터를 찾을 수 없는 경우
        //            } return
//                }
        
        // 2. 메인화면 버튼 클릭시 맵 페이지로 이동
//        @IBAction func goToMapButton(_ sender: UIButton) {
//            let mapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
//                mapViewController.modalPresentationStyle = .fullScreen
//                present(mapViewController, animated: true, completion: nil)
//            }
//        }
        
        // 3. 킥보드 대여중일 경우, 이용중 버튼 컬러가 활성화 / 이용중이 아닐시 비활성화 ⭐️⭐️⭐️
        // 4. 이용내역 표시하기 ⭐️⭐️⭐️⭐️⭐️
        // 5. 로그아웃 버튼 클릭시 로그인 페이지로 이동
        
    }
