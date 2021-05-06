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
        locationManager!.requestWhenInUseAuthorization()
        
        self.mapView.showsUserLocation = true
    }
}

extension ViewController: CLLocationManagerDelegate {
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.mapView.setCenter(location.coordinate, animated: true)
    }
}
