//
//  MapView.swift
//  Zeus
//
//  Created by Priyanshu Verma on 04/01/23.
//

import UIKit
import GoogleMaps

protocol LocalNewsDelegate {
    func showLocalNews(coordinate: CLLocationCoordinate2D, countryName: String, countryCode: String?)
}

final class MapView: UIViewController, CLLocationManagerDelegate {
    
    
    var localNewsDelegate: LocalNewsDelegate?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 0.5)
        let mapView = GMSMapView.map(withFrame: self.view.safeAreaLayoutGuide.layoutFrame, camera: camera)
        mapView.mapType = .terrain
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = false
        mapView.delegate = self
        self.view.addSubview(mapView)
    }
}

private typealias MapInteractionHandling = MapView
extension MapInteractionHandling: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = "Tapped Location"
        marker.map = mapView
        marker.infoWindowAnchor = marker.groundAnchor
        
        if !NetworkMonitor.shared.checkForNetworkConnectivity() {
            self.localNewsDelegate?.showLocalNews(coordinate: coordinate, countryName: "", countryCode: nil)
            return
        }
        print(coordinate)
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            print("Decoding country")
            if let error {
                print("Error Occured", error)
            }
            guard let response else {
                print("No response")
                return
            }
            if let address = response.firstResult() {
                print(address)
                if let countryName = address.country {
                    print(countryName)
                    self.localNewsDelegate?.showLocalNews(coordinate: coordinate, countryName: countryName, countryCode: UtilityClass.countryCodeDict[countryName])
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
