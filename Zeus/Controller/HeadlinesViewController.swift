////
////  HeadlinesViewController.swift
////  Zeus
////
////  Created by Priyanshu Verma on 03/01/23.
////
//
//import UIKit
//
//final class HeadlinesViewController: UIViewController, PassingFilter {
//    
//    var viewTitle: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = String(localized: "top_headlines")
//        label.font = .systemFont(ofSize: 32, weight: .bold)
//        return label
//    }()
//    
//    var filterButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage(systemName: "checklist"), for: .normal)
//        button.imageView?.contentMode = .scaleAspectFill
//        button.tintColor = .black
//        button.layer.cornerRadius = 10
//        button.backgroundColor = .systemYellow
//        return button
//    }()
//    
//    var newsView: NewsView = {
//        let view = NewsView()
//        view.tableView.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let loadingScreen = LoadingScreen()
//    private let noResultsFoundScreen = NoResultsFound()
//    private let noInternetConnectionScreen = NoInternetConnection()
//    
////    let categories = [
////        String(localized: "business"),
////        String(localized: "entertainment"),
////        String(localized: "general"),
////        String(localized: "health"),
////        String(localized: "science"),
////        String(localized: "sports"),
////        String(localized: "technology")
////    ]
////
////    let categoriesLocalisationMap = [
////        String(localized: "business"): "Business",
////        String(localized: "entertainment"): "Entertainment",
////        String(localized: "general"): "General",
////        String(localized: "health"): "Health",
////        String(localized: "science"): "Science",
////        String(localized: "sports"): "Sports",
////        String(localized: "technology"): "Technology"
////    ]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        if newsView.tableView.isHidden {
//            newsView.refreshTableView()
//        }
//    }
//    
//    fileprivate func setupView() {
//        view.backgroundColor = .systemBackground
//        
//        addSubviews()
//        addSubviewConstraints()
//        
//        loadingScreen.view.isHidden = true
//        noResultsFoundScreen.view.isHidden = true
//        noInternetConnectionScreen.view.isHidden = true
//        newsView.newsEventsDelegate = self
//        noInternetConnectionScreen.refreshDelegate = self
//        filterButton.addTarget(self, action: #selector(goToFilter), for: .touchUpInside)
//        
////        let refreshControl = UIRefreshControl()
////        refreshControl.addTarget(self, action: #selector(refreshNewsView), for: .valueChanged)
////        newsView.refreshControl = refreshControl
//    }
//    
////    @objc func refreshNewsView(refreshControl: UIRefreshControl) {
////        print(#function)
////        newsView.query = newsView.query
////        refreshControl.endRefreshing()
////    }
//    
//    fileprivate func addSubviews() {
//        view.addSubview(viewTitle)
//        view.addSubview(filterButton)
//        view.addSubview(newsView.tableView)
//        view.addSubview(loadingScreen.view)
//        view.addSubview(noResultsFoundScreen.view)
//        view.addSubview(noInternetConnectionScreen.view)
//    }
//    
//    fileprivate func addSubviewConstraints() {
//        addViewTitleConstraints()
//        addFilterButtonConstraints()
//        addNewsViewConstraints()
//        
//        addConstraintsTo(loadingScreen.view)
//        addConstraintsTo(noResultsFoundScreen.view)
//        addConstraintsTo(noInternetConnectionScreen.view)
////        addLoadingScreenConstraints()
////        addNoResultsFoundScreenConstraints()
//    }
//    
//    fileprivate func addViewTitleConstraints() {
//        viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
//        viewTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
//        viewTitle.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8).isActive = true
//        viewTitle.heightAnchor.constraint(equalToConstant: viewTitle.intrinsicContentSize.height).isActive = true
//    }
//    
//    fileprivate func addFilterButtonConstraints() {
//        filterButton.topAnchor.constraint(equalTo: viewTitle.topAnchor).isActive = true
//        filterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
//        filterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        filterButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
//    }
//    
//    fileprivate func addNewsViewConstraints() {
//        newsView.tableView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 12).isActive = true
//        newsView.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        newsView.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        newsView.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
//    }
//    
////    fileprivate func addLoadingScreenConstraints() {
////        loadingScreen.view.translatesAutoresizingMaskIntoConstraints = false
////        loadingScreen.view.topAnchor.constraint(equalTo: newsView.tableView.topAnchor).isActive = true
////        loadingScreen.view.leadingAnchor.constraint(equalTo: newsView.tableView.leadingAnchor).isActive = true
////        loadingScreen.view.trailingAnchor.constraint(equalTo: newsView.tableView.trailingAnchor).isActive = true
////        loadingScreen.view.bottomAnchor.constraint(equalTo: newsView.tableView.bottomAnchor).isActive = true
////    }
////
////    fileprivate func addNoResultsFoundScreenConstraints() {
////        noResultsFoundScreen.view.translatesAutoresizingMaskIntoConstraints = false
////        noResultsFoundScreen.view.topAnchor.constraint(equalTo: newsView.tableView.topAnchor).isActive = true
////        noResultsFoundScreen.view.leadingAnchor.constraint(equalTo: newsView.tableView.leadingAnchor).isActive = true
////        noResultsFoundScreen.view.trailingAnchor.constraint(equalTo: newsView.tableView.trailingAnchor).isActive = true
////        noResultsFoundScreen.view.bottomAnchor.constraint(equalTo: newsView.tableView.bottomAnchor).isActive = true
////    }
//    
//    fileprivate func addConstraintsTo(_ view: UIView) {
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.topAnchor.constraint(equalTo: newsView.tableView.topAnchor).isActive = true
//        view.leadingAnchor.constraint(equalTo: newsView.tableView.leadingAnchor).isActive = true
//        view.trailingAnchor.constraint(equalTo: newsView.tableView.trailingAnchor).isActive = true
//        view.bottomAnchor.constraint(equalTo: newsView.tableView.bottomAnchor).isActive = true
//    }
//    
//    @objc func goToFilter() {
//        let filterScreen = FilterPage()
//        filterScreen.filterDelegate = self
//        if let sheet = filterScreen.sheetPresentationController {
//            sheet.detents = [.medium()]
//        }
//        self.navigationController?.present(filterScreen, animated: true)
//        view.snapshotView(afterScreenUpdates: true)
//    }
//    
//    // MARK: - PassingFilter Protocol Conformation
//    
//    var filter: Set<Int> = [] {
//        didSet {
//            var filterString = ""
//            for index in filter {
//                if let category = UtilityClass.categoriesLocalisationMap[UtilityClass.categories[index]] {
//                    filterString.append("&category=\(category.lowercased())")
//                }
//            }
//            newsView.setQuery(filter: filterString)
//        }
//    }
//    
//    func passFilter(filter: Set<Int>) {
//        self.filter = filter
//    }
//    
//    // MARK: - Navigation
//
//}
//
//private typealias ShowWebView = HeadlinesViewController
//extension ShowWebView: HandleNewsViewEvents {
//    func loadWebView(url: String?) {
//        let webView = WebView()
//        webView.webURL = url
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.pushViewController(webView, animated: true)
//    }
//    
//    func showLoadingScreen(_ shouldShow: Bool) {
//        newsView.tableView.isHidden = shouldShow
//        noResultsFoundScreen.view.isHidden = true
//        loadingScreen.view.isHidden = !shouldShow
//        noInternetConnectionScreen.view.isHidden = true
//    }
//    
////    func removeLoadingScreen() {
////        newsView.tableView.isHidden = false
////        loadingScreen.view.isHidden = true
////    }
//    
//    func showNoResltsFoundScreen(_ shouldShow: Bool) {
//        newsView.tableView.isHidden = shouldShow
//        noResultsFoundScreen.view.isHidden = !shouldShow
//        loadingScreen.view.isHidden = true
//        noInternetConnectionScreen.view.isHidden = true
//    }
//    
//    func showNoInternetScreen(_ shouldShow: Bool) {
//        print(#function)
//        newsView.tableView.isHidden = shouldShow
//        noResultsFoundScreen.view.isHidden = true
//        loadingScreen.view.isHidden = true
//        noInternetConnectionScreen.view.isHidden = !shouldShow
//    }
//}
//
//private typealias ReCheckNetworkConnectivity = HeadlinesViewController
//extension ReCheckNetworkConnectivity: TryRefreshNews {
//    func refreshNews() {
//        newsView.refreshTableView()
//    }
//}
