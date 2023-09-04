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
    var captureSession: AVCaptureSession?
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
        let dummyImageView = UIImageView(image: UIImage(named: "dummyCameraImage"))
        dummyImageView.frame = cameraView.bounds
        dummyImageView.contentMode = .scaleAspectFit
        cameraView.addSubview(dummyImageView)
        
        // 버튼을 추가하여 더미 데이터 확인 로직을 테스트
        let checkButton = UIButton(frame: CGRect(x: 20, y: 50, width: 100, height: 50))
        checkButton.setTitle("Check", for: .normal)
        checkButton.backgroundColor = .blue
        checkButton.addTarget(self, action: #selector(checkDummyData), for: .touchUpInside)
        view.addSubview(checkButton)
        
        let alert = UIAlertController(title: "Notice", message: "Camera is not available on simulator. Using dummy data instead.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
#else
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
            DispatchQueue.global().async { [weak self] in
                self?.captureSession?.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession?.isRunning == true {
            DispatchQueue.global().async { [weak self] in
                self?.captureSession?.stopRunning()
            }
        }
    }
    
    
    // MARK: - Setup Methods
    @objc func checkDummyData() {
        found(code: "12345-abcde-67890")
    }
    
    func loadKickboardInfo() {
        kickboardInfo = Kickboard(uniqueID: "12345-abcde-67890", isRented: false)
    }
    
    private func setupCameraSession() {
        captureSession = AVCaptureSession()
        
        guard let captureSession = captureSession else { return }
        
        configureVideoInput(session: captureSession)
        configureMetadataOutput(session: captureSession)
        
        setupPreviewLayer(session: captureSession)
        
        DispatchQueue.global().async {
            captureSession.startRunning()
        }
    }
    
    private func configureVideoInput(session: AVCaptureSession) {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            
            if session.canAddInput(videoInput) {
                session.addInput(videoInput)
            } else {
                displayErrorAlert(message: "Unable to add video input.")
            }
            
        } catch {
            displayErrorAlert(message: "Error configuring video input: \(error.localizedDescription)")
        }
    }
    
    private func configureMetadataOutput(session: AVCaptureSession) {
        let metadataOutput = AVCaptureMetadataOutput()
        
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr, .ean13, .ean8, .upce]
        } else {
            displayErrorAlert(message: "Unable to add metadata output.")
        }
    }
    
    private func setupPreviewLayer(session: AVCaptureSession) {
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = cameraView.bounds
        previewLayer.videoGravity = .resizeAspectFill
        cameraView.layer.addSublayer(previewLayer)
    }
    
    private func displayErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
        
        DispatchQueue.main.async { // 메인 스레드에서 실행
            self.captureSession?.stopRunning()
        }
        
        if let kickboardInfo = kickboardInfo, code == kickboardInfo.uniqueID {
            // 킥보드 정보 표시
            let alert = UIAlertController(title: "Success", message: "대여 완료!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.isAlertShown = false
                DispatchQueue.main.async { // 메인 스레드에서 실행
                    self.captureSession?.startRunning()
                    self.dismiss(animated: true, completion: nil)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate)) // 한 번만 진동 효과 추가
            // 에러 메시지 표시
            let alert = UIAlertController(title: "Error", message: "킥보드 정보가 일치하지 않습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.isAlertShown = false // 얼럿이 닫힐 때 플래그를 리셋하고 캡처 세션을 다시 시작
                DispatchQueue.main.async { // 메인 스레드에서 실행
                    self.captureSession?.startRunning()
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
}
