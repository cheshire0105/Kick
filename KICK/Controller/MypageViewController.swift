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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addProfilePhoto: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userContact: UITextField!
    @IBOutlet weak var userCredit: UITextField!
    @IBOutlet weak var userLicense: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUserData()
        setupProfilePhoto()
//        editProfile()
    }
    // 💡마이페이지 메서드 모음💡
//    func setupUserData() {
//        guard let userID = currentUserID else {
//            return dismiss(animated: true, completion: nil)
//        }
//        if let user = UserManager.shared.getUser(id: userID) {
//            // 유저정보를 화면에 표시
//        } else {
//            // 유저 데이터를 찾을 수 없는 경우
//            // 로그인을 요망 에러 표시, 에러는 파일 하단에 정리해놓음.
//            return dismiss(animated: true, completion: nil)
//        }
//    }

    // 💡수정페이지 메서드 모음💡
    // 등록버튼 클릭시(유저 데이터 저장 및 업데이트)
    @IBAction func editProfile(_ sender: Any) {
        guard let userID = currentUserID else {
            return dismiss(animated: true, completion: nil)
        }
        if let user = userData.getUser(id: userID) {
            var userName = userName.text
            var userContact = userContact.text
            var userCredit = userCredit.text
            var userLicense = userLicense.text
            
//            userData.userName.append(userName ?? "이름 없음")
//            
//            defaults.set(userData.userName, forKey: "userName")
            
            
        } else {
            return dismiss(animated: true, completion: nil)
        }
    }
    
    // 취소버튼 클릭시(MyPage로 화면전환)
    @IBAction func backToMypage(_ sender: Any) {
        if self.presentingViewController != nil {
             self.dismiss(animated: true)
           } else if self.navigationController != nil {
             self.navigationController?.popViewController(animated: true)
           }
    }
    
    // 프로필 이미지 등록
    func setupProfilePhoto() {
        addProfilePhoto?.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside)
    }
    // 사진이 표시되는 프레임
    func photoFrame() {
        let safeArea = view.safeAreaLayoutGuide; NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    // 사진 업로드
    @objc func uploadPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}
extension MypageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageView.contentMode = .scaleAspectFit
                imageView.image = pickedImage
            }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

class ErrorHandler: UIViewController {
    
    enum ErrorsInMypage{
        case notLoggedIn
    }
    
    func displayError(for errorType: ErrorsInMypage) {
        let alert: UIAlertController
        
        switch errorType {
        case .notLoggedIn:
            alert = UIAlertController(title: "로그인 요망", message: "앱사용을 원하시면 로그인을 해주시기 바랍니다", preferredStyle: .alert)
        }
        let dismissAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        present(alert, animated: true)
    }
}
