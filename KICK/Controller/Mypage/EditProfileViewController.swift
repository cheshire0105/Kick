//
//  MypageViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//
import Foundation
import UIKit

class EditProfileViewController: UIViewController {

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
    // 등록버튼 클릭시(유저 데이터 저장 및 업데이트)
    @IBAction func editProfile(_ sender: Any) {
        guard let userID = currentUserID else {
            return dismiss(animated: true, completion: nil)
        }
        if let user = userData.getUser(id: userID) {
            var newUser = user
            newUser.userName = userName.text ?? newUser.userName
            newUser.userContact = userContact.text ?? newUser.userContact
            newUser.userCredit = userCredit.text ?? newUser.userCredit
            newUser.userLicense = userLicense.text ?? newUser.userLicense
            
            userData.saveUser(user: newUser) // 유저 데이터를 수정하고 저장
            
        } else {
            return dismiss(animated: true, completion: nil)
        }
    }
    // 회원탈퇴버튼 클릭시(유저정보 삭제)
    @IBAction func removeUser(_ sender: Any) {
        // 탈퇴의사를 재확인 하는 알럿 표시
        let deleteAlert = UIAlertController(title: "의사 재확인", message: "정말로 탈퇴하시겠습니까?", preferredStyle: .alert)
        // '아니오(철회)' 클릭시 -> dismiss
        let cancelAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        deleteAlert.addAction(cancelAction)
        present(deleteAlert, animated: true)
        // '네' 클릭시 -> 사용자 정보 삭제 후 -> 로그인 페이지로 이동 ⭐️⭐️⭐️
        let okAction = UIAlertAction(title: "네", style: .default, handler: nil)
        deleteAlert.addAction(okAction)
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

// 이미지 피커를 사용하기 위한 확장
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
