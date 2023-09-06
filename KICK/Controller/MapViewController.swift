
import UIKit
import SnapKit
import NMapsMap
import CoreLocation

class MapViewController: UIViewController, NMFMapViewOptionDelegate {

    // Properties
    private let mapView = NMFMapView()
    private let naverMapView = NMFNaverMapView()
    
    private let positionButton = NMFLocationButton()
    private let zoomControlButton = NMFZoomControlView()
    
    let locationManager = CLLocationManager()

    private let registerButton = {
        let button = UIButton()
        // button.setBackgroundImage(UIImage(systemName: "rectangle.fill"), for: .normal)
        button.addTarget(MapViewController.self, action: #selector(registerButtonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCoreLocation()

        DispatchQueue.global(qos: .default).async { [self] in
            var markers = [NMFMarker]()
            // 백그라운드 스레드
            for index in 1...5 {
                let marker = NMFMarker(position: NMGLatLng(lat: 37.36631851883025, lng: 127.10944555502921)
, iconImage: NMFOverlayImage(name: "KickBoard"))
                markers.append(marker)
            }

            DispatchQueue.main.async { [weak self] in
                // 메인 스레드
                for marker in markers {
                    marker.mapView = self?.mapView
                    marker.touchHandler = {(overlay: NMFOverlay) -> Bool in
                        print("오버레이 터치됨")
                        return true
                    }
                }
                
                print("marker 생성 완료")
                print("map 생성 시작")
                self?.configureMap()
                self?.configureLayout()
            }

        }
    }
    
    func configureMap() {
        /* 현재 위치 표시 */
        mapView.positionMode = .normal
        /* 현재 위치 찾아주는 버튼 설정 */
        positionButton.mapView = naverMapView.mapView
        /* 줌 버튼 */
        zoomControlButton.mapView = naverMapView.mapView
    }
    
    func configureLayout() {
        view.addSubview(mapView)
        view.addSubview(registerButton)
        view.addSubview(positionButton)
        view.addSubview(zoomControlButton)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        registerButton.backgroundColor = .red
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        positionButton.backgroundColor = .yellow
        positionButton.snp.makeConstraints { make in
            make.trailing.equalTo(registerButton.snp.trailing)
            make.bottom.equalTo(registerButton.snp.top).offset(-10)
        }
        zoomControlButton.backgroundColor = .blue
        zoomControlButton.snp.makeConstraints { make in
            make.leading.equalTo(positionButton.snp.leading)
            make.bottom.equalTo(positionButton.snp.top)
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

extension MapViewController: CLLocationManagerDelegate {
    
    func configureCoreLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        // 아이폰 설정에서의 위치 서비스가 켜진 상태라면
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation() //위치 정보 받아오기 시작
            print(locationManager.location?.coordinate)
        } else {
            print("위치 서비스 Off 상태")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.first {
            print("위도: \(location.coordinate.latitude)")
            print("경도: \(location.coordinate.longitude)")
        }
    }
}
