//
//  ViewController.swift
//  Tutorial06
//
//  Created by Kaito Hattori on 2021/05/06.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        // 位置情報の認証をリクエストする
        locationManager!.requestWhenInUseAuthorization()
        
        // ユーザーの位置情報をマップに表示するように設定
        self.mapView.showsUserLocation = true
        
        // マップにピンを追加
        let coordinate = CLLocationCoordinate2D(latitude: 35.6812, longitude: 139.7671)
        let pin = MKPointAnnotation()
        pin.title = "Tokyo Station"
        pin.coordinate = coordinate
        self.mapView.addAnnotation(pin)
    }
}

extension ViewController: CLLocationManagerDelegate {
    // 位置情報の認証情報が更新されたときに呼ばれる
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        default:
            break
        }
    }
    
    // ユーザー位置情報が更新された時に呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        // ユーザーの位置情報が中心になるように表示される
        self.mapView.setCenter(location.coordinate, animated: true)
    }
}
