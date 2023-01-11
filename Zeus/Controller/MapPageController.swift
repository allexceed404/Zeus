//
//  MapPageController.swift
//  Zeus
//
//  Created by Priyanshu Verma on 29/12/22.
//

import UIKit
import GoogleMaps
    
final class MapPageController: UIViewController {

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
    
//    fileprivate func newsViewConstraints() {
//        newsView.tableView.topAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>)
//    }

}

private typealias LoadingLocalNews = MapPageController
extension LoadingLocalNews: LocalNewsDelegate {
    func showLocalNews(coordinate: CLLocationCoordinate2D, countryName: String, countryCode: String) {
        let newsBottomSheet = NewsBottomSheet()
        lastCoordinates = coordinate
        
        if countryCode == "" {
            newsBottomSheet.setTitle(title: String(localized: "top_headlines"))
        } else {
            newsBottomSheet.setTitle(title: String(localized: "top_headlines") + ": " + countryName)
        }
        
        newsBottomSheet.setNewsViewQuery(query: "&country="+countryCode)
//        if let sheet = newsBottomSheet.sheetPresentationController {
//            sheet.detents = [.medium(), .large()]
//        }
        self.navigationController?.pushViewController(newsBottomSheet, animated: true)
    }
}

final class NewsBottomSheet: UIViewController {
    deinit {
        print("Deinit")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(localized: "top_headlines")
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .label
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let newsView: NewsView = {
        let view = NewsView()
        view.tableView.translatesAutoresizingMaskIntoConstraints = false
        view.baseQuery = "top-headlines?apiKey=\(Secrets.apiKey.rawValue)"
        return view
    }()
    
    private let loadingScreen = LoadingScreen()
    private let noResultsFoundScreen = NoResultsFound()
    private let noInternetConnectionScreen = NoInternetConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if newsView.tableView.isHidden {
            newsView.refreshTableView()
        }
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .systemBackground
        
        addSubviews()
        addSubviewConstraints()
        
        loadingScreen.view.isHidden = true
        noResultsFoundScreen.view.isHidden = true
        noInternetConnectionScreen.view.isHidden = true
        newsView.newsEventsDelegate = self
        noInternetConnectionScreen.refreshDelegate = self
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(newsView.tableView)
        view.addSubview(loadingScreen.view)
        view.addSubview(noResultsFoundScreen.view)
        view.addSubview(noInternetConnectionScreen.view)
    }
    
    fileprivate func addSubviewConstraints() {
        addTitleLabelConstraints()
        addCloseButtonConstraints()
        addNewsViewConstraints()
        
        addConstraintsTo(loadingScreen.view)
        addConstraintsTo(noResultsFoundScreen.view)
        addConstraintsTo(noInternetConnectionScreen.view)
//        addLoadingScreenConstraints()
//        addNoResultsFoundScreenConstraints()
    }
    
    fileprivate func addTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.height).isActive = true
    }
    
    fileprivate func addCloseButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        closeButton.imageView?.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor).isActive = true
        closeButton.imageView?.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        closeButton.imageView?.widthAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 1).isActive = true
        closeButton.imageView?.heightAnchor.constraint(equalTo: closeButton.heightAnchor, multiplier: 1).isActive = true
    }
    
    fileprivate func addNewsViewConstraints() {
        newsView.tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        newsView.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        newsView.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        newsView.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
//    fileprivate func addLoadingScreenConstraints() {
//        loadingScreen.view.translatesAutoresizingMaskIntoConstraints = false
//        loadingScreen.view.topAnchor.constraint(equalTo: newsView.tableView.topAnchor).isActive = true
//        loadingScreen.view.leadingAnchor.constraint(equalTo: newsView.tableView.leadingAnchor).isActive = true
//        loadingScreen.view.trailingAnchor.constraint(equalTo: newsView.tableView.trailingAnchor).isActive = true
//        loadingScreen.view.bottomAnchor.constraint(equalTo: newsView.tableView.bottomAnchor).isActive = true
//    }
//    
//    fileprivate func addNoResultsFoundScreenConstraints() {
//        noResultsFoundScreen.view.translatesAutoresizingMaskIntoConstraints = false
//        noResultsFoundScreen.view.topAnchor.constraint(equalTo: newsView.tableView.topAnchor).isActive = true
//        noResultsFoundScreen.view.leadingAnchor.constraint(equalTo: newsView.tableView.leadingAnchor).isActive = true
//        noResultsFoundScreen.view.trailingAnchor.constraint(equalTo: newsView.tableView.trailingAnchor).isActive = true
//        noResultsFoundScreen.view.bottomAnchor.constraint(equalTo: newsView.tableView.bottomAnchor).isActive = true
//    }
    
    fileprivate func addConstraintsTo(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: newsView.tableView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: newsView.tableView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: newsView.tableView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: newsView.tableView.bottomAnchor).isActive = true
    }
    
    @objc func closeView() {
//        dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNewsViewQuery(query: String) {
        newsView.setQuery(filter: query)
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
}

private typealias ShowWebView = NewsBottomSheet
extension ShowWebView: HandleNewsViewEvents {
    func loadWebView(url: String?) {
        let webView = WebView()
        webView.webURL = url
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    func showLoadingScreen(_ shouldShow: Bool) {
        newsView.tableView.isHidden = shouldShow
        noResultsFoundScreen.view.isHidden = true
        loadingScreen.view.isHidden = !shouldShow
        noInternetConnectionScreen.view.isHidden = true
    }
    
//    func removeLoadingScreen() {
//        newsView.tableView.isHidden = false
//        loadingScreen.view.isHidden = true
//    }
    
    func showNoResltsFoundScreen(_ shouldShow: Bool) {
        newsView.tableView.isHidden = shouldShow
        noResultsFoundScreen.view.isHidden = !shouldShow
        loadingScreen.view.isHidden = true
        noInternetConnectionScreen.view.isHidden = true
    }
    
    func showNoInternetScreen(_ shouldShow: Bool) {
        print(#function)
        newsView.tableView.isHidden = shouldShow
        noResultsFoundScreen.view.isHidden = true
        loadingScreen.view.isHidden = true
        noInternetConnectionScreen.view.isHidden = !shouldShow
    }
}

private typealias ReCheckNetworkConnectivity = NewsBottomSheet
extension ReCheckNetworkConnectivity: TryRefreshNews {
    func refreshNews() {
        newsView.refreshTableView()
    }
}
