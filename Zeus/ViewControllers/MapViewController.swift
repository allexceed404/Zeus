//
//  MapViewController.swift
//  Zeus
//
//  Created by Priyanshu Verma on 17/01/23.
//

import UIKit
import GoogleMaps

final class MapViewController: UIViewController {

    var mapView: MapView = {
        let map = MapView()
        map.view.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    var lastCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    fileprivate func setupView() {
        addSubviews()
        addSubviewConstraints()

        mapView.localNewsDelegate = self
    }

    fileprivate func addSubviews() {
        view.addSubview(mapView.view)
    }

    fileprivate func addSubviewConstraints() {
        addMapViewConstraints()
    }

    fileprivate func addMapViewConstraints() {
        mapView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mapView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

private typealias LoadingLocalNews = MapViewController
extension LoadingLocalNews: LocalNewsDelegate {
    func showLocalNews(coordinate: CLLocationCoordinate2D, countryName: String, countryCode: String?) {
        let newsView = TopHeadlinesViewController()
        let newsViewModel = newsView.getNewsViewModel()
        lastCoordinates = coordinate
        
        newsView.setTitle(to: String(localized: "top_headlines") + ": " + countryName, size: 24)
        if countryCode == nil {
            newsViewModel?.setEndpoint(to: .everything)
        }

        newsViewModel?.setCountry(to: countryName)
        self.navigationController?.pushViewController(newsView, animated: true)
    }
}
