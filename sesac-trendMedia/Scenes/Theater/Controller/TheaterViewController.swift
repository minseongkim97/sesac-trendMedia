//
//  TheaterViewController.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/11.
//

import UIKit
import MapKit
import CoreLocation

class TheaterViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        checkUserDeviceLocationServiceAuthorization()
        setRegionAndAnnotation()
    }
    
    //MARK: - Helpers
    func setRegionAndAnnotation() {
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        
        mapView.addAnnotation(annotation)
    }
}

//MARK: - Extension: 위치 관련된 User Defined 메서드
extension TheaterViewController {
    // 위치 서비스가 켜져 있다면 권한 요청. 꺼져 있다면 커스텀 alert 띄워주기
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // iOS 위치 서비스 활성화 여부 체크: locationServicesEnabled()
        if CLLocationManager.locationServicesEnabled() {
            // 위치 서비스가 활성화 되어 있으므로, 위치 권한 요청 가능해서 위치 권한을 요청
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안 위치 권한 요청. plist whenInUser 항목이 있어야 사용가능
            
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            // 사용자가 위치를 허용해둔 상태라면, startUpdatingLocation
            locationManager.startUpdatingLocation()
        default:
            print("DEFAULT")
        }
    }
}

//MARK: - Extension: CLLocationManagerDelegate
extension TheaterViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
}

//MARK: - Extension: MKMapViewDelegate
extension TheaterViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        <#code#>
//    }
    
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        <#code#>
//    }
}
