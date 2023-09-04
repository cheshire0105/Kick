//
//  KickBoardRegisterViewController.swift
//  KICK
//
//  Created by cheshire on 2023/09/04.
//

import UIKit
import AVFoundation



class KickBoardRegisterViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var kickboardInfoLabel: UILabel!
    
    // MARK: - Properties
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var isAlertShown = false
    
    
    var kickboardInfo: Kickboard? {
        didSet {
            displayKickboardInfo()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
#if targetEnvironment(simulator)
    // 시뮬레이터에서 실행되는 경우: 카메라 기능을 비활성화하거나 모의 데이터를 사용
    let dummyImageView = UIImageView(image: UIImage(named: "dummyCameraImage"))
    dummyImageView.frame = cameraView.bounds
    dummyImageView.contentMode = .scaleAspectFit
    cameraView.addSubview(dummyImageView)
    
    let alert = UIAlertController(title: "Notice", message: "Camera is not available on simulator. Using dummy data instead.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alert, animated: true)
#else
    // 실제 디바이스에서 실행되는 경우: 카메라 기능을 활성화
    setupCameraSession()
#endif

        
        loadKickboardInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = cameraView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if captureSession?.isRunning == false {
            DispatchQueue.global().async {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession?.isRunning == true {
            DispatchQueue.global().async {
                self.captureSession.stopRunning()
            }
        }
    }
    
    // MARK: - Setup Methods
    func loadKickboardInfo() {
        // 더미 데이터를 사용하여 kickboardInfo 프로퍼티를 설정
        kickboardInfo = Kickboard(uniqueID: "12345-abcde-67890", isRented: false)
    }
    
    private func setupCameraSession() {
        captureSession = AVCaptureSession()
        
        configureVideoInput()
        configureMetadataOutput()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = cameraView.bounds
        previewLayer.videoGravity = .resizeAspectFill
        cameraView.layer.addSublayer(previewLayer)
        
        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
    }
    
    private func configureVideoInput() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            // 적절한 에러 처리를 추가하세요
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            // 적절한 에러 처리를 추가하세요
            return
        }
    }
    
    private func configureMetadataOutput() {
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr, .ean13, .ean8, .upce] // 필요한 타입을 여기에 추가하세요
        } else {
            // 적절한 에러 처리를 추가하세요
            return
        }
    }
    
    // MARK: - Helper Methods
    private func displayKickboardInfo() {
        if let kickboardInfo = kickboardInfo {
            kickboardInfoLabel.text = "Kickboard Info:\nID: \(kickboardInfo.uniqueID)\nStatus: \(kickboardInfo.isRented ? "Rented" : "Available")"
        } else {
            kickboardInfoLabel.text = "No kickboard info available"
        }
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension KickBoardRegisterViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate)) // 진동 효과 추가
            found(code: stringValue)
        }
    }
    
    private func found(code: String) {
        if isAlertShown {
            return
        }
        
        isAlertShown = true
        
        DispatchQueue.global().async {
            self.captureSession.stopRunning() // 백그라운드 스레드에서 호출
        }
        
        if let kickboardInfo = kickboardInfo, code == "12345-abcde-67890" {
            // 킥보드 정보 표시
            let alert = UIAlertController(title: "Success", message: "대여 완료!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.isAlertShown = false
                DispatchQueue.global().async {
                    self.captureSession.startRunning() // 백그라운드 스레드에서 호출
                }
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate)) // 한 번만 진동 효과 추가
            // 에러 메시지 표시
            let alert = UIAlertController(title: "Error", message: "킥보드 정보가 일치하지 않습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.isAlertShown = false // 얼럿이 닫힐 때 플래그를 리셋하고 캡처 세션을 다시 시작
                DispatchQueue.global().async {
                    self.captureSession.startRunning() // 백그라운드 스레드에서 호출
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
}
