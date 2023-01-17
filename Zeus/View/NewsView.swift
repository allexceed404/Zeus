////
////  NewsView.swift
////  Zeus
////
////  Created by Priyanshu Verma on 03/01/23.
////
//
//import UIKit
//
//protocol HandleNewsViewEvents {
//    func loadWebView(url: String?)
//    func showLoadingScreen(_ shouldShow: Bool)
////    func removeLoadingScreen()
//    func showNoResltsFoundScreen(_ shouldShow: Bool)
//    func showNoInternetScreen(_ shouldShow: Bool)
//}
//
//final class NewsView: UITableViewController {
//
//    private var articlesPerPage = 20
//    private var currentPage = 1
//    private var activeLoadingScreen = true {
//        didSet {
//            DispatchQueue.main.async {
//                if self.activeLoadingScreen {
//                    self.newsEventsDelegate?.showLoadingScreen(true)
//                } else {
//                    self.newsEventsDelegate?.showLoadingScreen(false)
//                }
//            }
//        }
//    }
//    private var resultsFound = false {
//        didSet {
//            DispatchQueue.main.async {
//                self.newsEventsDelegate?.showNoResltsFoundScreen(!self.resultsFound)
//            }
//        }
//    }
//    
//    private var isConnected = false {
//        didSet {
//            DispatchQueue.main.async {
//                if !self.isConnected {
//                    self.newsEventsDelegate?.showNoInternetScreen(true)
//                }
//            }
//        }
//    }
//    
//    var articles = [Articles]() {
//        didSet {
//            DispatchQueue.main.async {
//                if self.articles.count == 0 {
//                    self.newsEventsDelegate?.showNoResltsFoundScreen(true)
//                }
//                self.tableView.reloadData()
//            }
//        }
//    }
//    
//    var baseQuery = "top-headlines?language=en&apiKey=" + Secrets.apiKey.rawValue
//    var query: String = "" {
//        didSet {
//            articles = []
//            activeLoadingScreen = true
//            fetchArticles(query: query)
//        }
//    }
//    
//    var newsEventsDelegate: HandleNewsViewEvents?
//    private var debounceTimer: Timer?
//    
//    override func viewDidLoad() {
//        print(#function)
//        super.viewDidLoad()
//        setupView()
//        addPullToRefresh()
//    }
//
//    fileprivate func setupView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(NewsPreviewCell.self, forCellReuseIdentifier: "NewsPreviewCell")
////        tableView.rowHeight = 300
//        tableView.rowHeight = UITableView.automaticDimension
////        tableView.estimatedRowHeight = 150
//        tableView.separatorStyle = .none
//        
//        setQuery(filter: "")
//    }
//    
//    fileprivate func addPullToRefresh() {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(refreshNewsView), for: .valueChanged)
//        refreshControl.tintColor = .systemYellow
//        self.refreshControl = refreshControl
//    }
//    
//    @objc func refreshNewsView(refreshControl: UIRefreshControl) {
//        print(#function)
//        articles = []
//        currentPage = 1
//        activeLoadingScreen = true
//        fetchArticles(query: query)
//        refreshControl.endRefreshing()
//    }
//    
//    func refreshTableView() {
//        articles = []
//        currentPage = 1
//        activeLoadingScreen = true
//        fetchArticles(query: query)
//    }
//    
//    func setQuery(filter: String) {
//        debounceTimer?.invalidate()
//        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.10, repeats: false) {[weak self] _ in
//            if let self {
//                self.query = self.baseQuery + filter
//            }
//        }
//    }
//    
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return articles.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPreviewCell") as? NewsPreviewCell else {
//            return UITableViewCell()
//        }
//        let article = articles[indexPath.row]
//        cell.set(data: article)
//        if(currentPage*articlesPerPage<100 && indexPath.row == Int(currentPage*articlesPerPage - articlesPerPage/2)) {
//            activeLoadingScreen = false
//            currentPage += 1
//            fetchArticles(query: query + "&page=\(currentPage)")
//        }
//        return cell
//    }
//    
//    // MARK: - Cell Function
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        newsEventsDelegate?.loadWebView(url: articles[indexPath.row].url)
//    }
//}
//
//private typealias ArticleFetching = NewsView
//extension ArticleFetching{
//    func fetchArticles(query: String) {
//        Networking.sharedInstance.getNews(query: query) {[weak self] result in
//            self?.activeLoadingScreen = false
//            switch result{
//            case .success(let news):
//                self?.resultsFound = true
//                self?.isConnected = true
//                guard let fetchedNewsArticles = news.articles else {
//                    return
//                }
//                if let newsArticles = self?.articles {
//                    self?.articles = newsArticles + fetchedNewsArticles
//                } else {
//                    self?.articles = fetchedNewsArticles
//                }
//            case .failure(let error):
//                print(error)
//                switch error {
//                case .NoDataAvailable:
//                    self?.resultsFound = false
//                case .NoInternetConnection:
//                    print("No Connection Found!")
//                    self?.isConnected = false
//                default:
//                    self?.resultsFound = false
//                    print(error)
//                }
//            }
//        }
//    }
////    func fetchArticlesByPage(query: String) {
////        Networking.sharedInstance.getNews(query: query) {[weak self] result in
////            switch result{
////            case .success(let news):
////                self?.articles = news.articles
////            case .failure(let error):
////                print(error)
////            }
////        }
////    }
//}
