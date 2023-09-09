
import UIKit
import SnapKit
import NMapsMap
import CoreLocation

class MapViewController: UIViewController, NMFMapViewOptionDelegate, NMFMapViewDelegate {
    
    // Properties
    private let mapView = NMFMapView()
    private let naverMapView = NMFNaverMapView()
    
    private let positionButton = NMFLocationButton()
    
    private let locationManager = CLLocationManager()
    private var kickboardCoordinates = [[Double]]()
    private var currentLatitude = 0.0
    private var currentLongitude = 0.0
    
    let kickboardManager = KickboardManager.shared
    
    private let registerButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .lightGray
        button.setTitle("등록하기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.isEnabled = false 
        
        button.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCoreLocation()
        setupMapAndMarkers()
        
    }
    
    func configureMap() {
        mapView.touchDelegate = self
        /* 현재 위치 표시 */
        mapView.positionMode = .normal
        /* 현재 위치 찾아주는 버튼 설정 */
        positionButton.mapView = naverMapView.mapView
    }
    
    func configureLayout() {
        view.addSubview(mapView)
        view.addSubview(registerButton)
        view.addSubview(positionButton)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        positionButton.snp.makeConstraints { make in
            make.trailing.equalTo(registerButton.snp.trailing)
            make.bottom.equalTo(registerButton.snp.top).offset(-10)
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

extension MapViewController: CLLocationManagerDelegate, NMFMapViewTouchDelegate {
    
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
            currentLatitude = location.coordinate.latitude
            currentLongitude = location.coordinate.longitude
            print("위도: \(location.coordinate.latitude)")
            print("경도: \(location.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func generateRandomLocation() {
        let radiusInMeters = 3000.0 // 1km 반경 내에서 랜덤 좌표 생성
        let center = CLLocationCoordinate2D(latitude: 37.36631851883025, longitude: 127.10944555502921)
        
        for _ in 1...25 {
            // 중심 좌표를 기준으로 랜덤한 거리와 방향 생성
            let randomDistance = Double.random(in: 0...radiusInMeters)
            let randomDirection = Double.random(in: 0...(2 * .pi))
            // 새로운 좌표 계산
            let latitude = center.latitude + (randomDistance / 111_000) * sin(randomDirection)
            let longitude = center.longitude + (randomDistance / (111_000 * cos(center.latitude))) * cos(randomDirection)
            
            kickboardCoordinates.append([latitude, longitude])
        }
        
        print(kickboardCoordinates)
    }
    
    func setupMapAndMarkers() {
        DispatchQueue.global(qos: .default).async { [self] in
            generateRandomLocation()
            var markers: [[Any]] = []

            // 백그라운드 스레드
            for index in kickboardCoordinates {
                let marker = NMFMarker(position: NMGLatLng(lat: index[0], lng: index[1]), iconImage: NMFOverlayImage(name: "KickBoard"))
                let kickboard = Kickboard(uniqueID: UUID().uuidString, isRented: false, batteryLevel: 75)
                kickboardManager.saveKickboard(kickboard: kickboard)
                markers.append([marker, kickboard.uniqueID])
            }
            
            DispatchQueue.main.async { [weak self] in
                // 메인 스레드
                for item in markers {
                    if let marker = item[0] as? NMFMarker, let uniqueID = item[1] as? String {
                        marker.mapView = self?.mapView
                        marker.touchHandler = { [weak self] (overlay: NMFOverlay) -> Bool in
                            self?.handleMarkerTouch(uniqueId: uniqueID)
                             return true
                        }
                    }
                }

                self?.configureMap()
                self?.configureLayout()
            }
        }
    }
    
    func handleMarkerTouch(uniqueId: String) {
        print("마커 클릭함")
        registerButton.backgroundColor = .red
        registerButton.isEnabled = true
    }
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("지도를 탭했습니다.")
        registerButton.backgroundColor = .lightGray
        registerButton.isEnabled = false
    }

}
