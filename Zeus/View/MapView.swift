//
//  MapView.swift
//  Zeus
//
//  Created by Priyanshu Verma on 04/01/23.
//

import UIKit
import GoogleMaps

//let countryCodeDict: [String:String] = ["United States":"us", "India":"in", "United Arab Emirates":"ae", "Argentina":"ar", "Austria":"at", "Australia":"au", "Belgium":"be", "Bulgaria":"bg", "Brazil":"br", "Canada":"ca", "Switzerland":"ch", "China":"cn", "Colombia":"co", "Cuba":"cu", "Czechia":"cz", "Germany":"de", "Egypt":"eg", "France":"fr", "United Kingdom":"gb", "Greece":"gr", "Hong Kong":"hk", "Hungary":"hu", "Indonesia":"id", "Ireland":"ie", "Israel":"il", "Italy":"it", "Japan":"jp", "Korea":"kr", "Lithuania":"lt", "Latvia":"lv", "Morocco":"ma", "Mexico":"mx", "Malaysia":"my", "Nigeria":"ng", "Netherlands":"nl", "Norway":"no", "New Zealand":"nz", "Philippines":"ph", "Poland":"pl", "Portugal":"pt", "Romania":"ro", "Serbia":"rs", "Russia":"ru", "Saudi Arabia":"sa", "Sweden":"se", "Singapore":"sg", "Slovenia":"si", "Slovakia":"sk", "Thailand":"th", "Turkey":"tr", "Taiwan":"tw", "Ukraine":"ua", "Venezuela":"ve", "South Africa":"za",
//                                        "यूनाइटेड स्टेट्‍स": "us", "भारत": "in", "संयुक्त अरब अमीरात": "ae", "अर्जेंटीना": "ar", "ऑस्ट्रिया": "at", "ऑस्ट्रेलिया": "au", "बेल्जियम": "be", "बुल्गारिया": "bg", "ब्राज़ील": "br"
//]

protocol LocalNewsDelegate {
    func showLocalNews(coordinate: CLLocationCoordinate2D, countryName: String, countryCode: String)
}

final class MapView: UIViewController, CLLocationManagerDelegate {
    
    
    var localNewsDelegate: LocalNewsDelegate?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Ask for Authorisation from the User.
//        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        DispatchQueue.main.async {
            self.locationManager.requestWhenInUseAuthorization()
        }
        

        
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 0.5)
        let mapView = GMSMapView.map(withFrame: self.view.safeAreaLayoutGuide.layoutFrame, camera: camera)
        mapView.mapType = .terrain
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = false
        mapView.delegate = self
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

private typealias MapInteractionHandling = MapView
extension MapInteractionHandling: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        print("\(coordinate.latitude)")
        marker.title = "Tapped Location"
        marker.map = mapView
        marker.infoWindowAnchor = marker.groundAnchor
        
        if !NetworkMonitor.shared.checkForNetworkConnectivity() {
            self.localNewsDelegate?.showLocalNews(coordinate: coordinate, countryName: "", countryCode: "")
            return
        }
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let error {
                print("Error Occured", error)
            }
            guard let response else {
                print("No response")
                return
            }
            if let address = response.firstResult() {
                if let countryName = address.country {
                    print(countryName)
                    if let countryCode = UtilityClass.countryCodeDict[countryName] {
                        print(countryCode)
                        self.localNewsDelegate?.showLocalNews(coordinate: coordinate, countryName: countryName, countryCode: countryCode)
                    }
                    
                }
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(#function)
        marker.map = nil
        return true
    }
}
