////
////  TopNewsPageController.swift
////  Zeus
////
////  Created by Priyanshu Verma on 29/12/22.
////
//
//import UIKit
//
//class TopNewsPageController: TableViewController {
//    
//    var filter: Set<String> = []
//    
//    func passFilter(filter: Set<String>) {
//        if(filter.count != 0) {
////            self.query = "top-headlines?language=en&apiKey=" + Secrets.apiKey.rawValue + filter
//        }
//    }
//    
//    
//    var articles = [Articles]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//    
//    var query: String = "top-headlines?language=en&apiKey=" + Secrets.apiKey.rawValue {
//        didSet {
//            fetchArticles(query: query)
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//    }
//    
//    fileprivate func setupView() {
//        tableView.register(NewsPreviewCell.self, forCellReuseIdentifier: "NewsPreviewCell")
//        tableView.rowHeight = 300
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//        
//        navigationController?.navigationBar.prefersLargeTitles = true
//        
//        
//        self.title = "Top Headlines"
//        let filterButton = UIBarButtonItem(image: UIImage(systemName: "checklist"), style: .done, target: self, action: #selector(goToFilter))
//        filterButton.tintColor = .label
//        self.navigationItem.rightBarButtonItem = filterButton
//        
//        fetchArticles(query: query)
//    }
//    
////    func fetchArticles(query: String) {
////        articles = self.fetchData(query: query)
////    }
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
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let webView = WebView()
//        webView.webURL = articles[indexPath.row].url
//        self.navigationController?.pushViewController(webView, animated: true)
//    }
//    
//    @objc func goToFilter() {
////        let filterScreen = FilterPage()
////        filterScreen.filterDelegate = self
////        self.navigationController?.present(filterScreen, animated: true)
////        view.snapshotView(afterScreenUpdates: true)
//    }
//    
//}
//
//private typealias ArticlesFetching = TopNewsPageController
//extension ArticlesFetching {
//    func fetchArticles(query: String) {
//        Networking.sharedInstance.getNews(query: query) {[weak self] result in
//            switch result{
//            case .success(let news):
//                self?.articles = news.articles
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}
