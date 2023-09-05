//
//  MypageViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//
import Foundation
import UIKit

class MypageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addProfilePhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfilePhoto()
    }
    
    @IBAction func backToMypage(_ sender: Any) {
        if self.presentingViewController != nil {
             self.dismiss(animated: true)
           } else if self.navigationController != nil {
             self.navigationController?.popViewController(animated: true)
           }
    }
    func setupProfilePhoto() {
        addProfilePhoto.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside)
        view.addSubview(imageView)
        view.addSubview(addProfilePhoto)
    }
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
