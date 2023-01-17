//
//  NewsViewController.swift
//  Zeus
//
//  Created by Priyanshu Verma on 12/01/23.
//

import UIKit

protocol LoadingNewsWebView {
    func loadNewsWebView(_ newsWebView: WebView)
}

extension LoadingNewsWebView where Self: UIViewController {
    func loadNewsWebView(_ newsWebView: WebView) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(newsWebView, animated: true)
    }
}

final class NewsViewController: UITableViewController {

    private var viewModel = NewsViewModel()
    private var debounceTimer: Timer?
    private var newsWebViewLoadingDelegate: LoadingNewsWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addRefreshControl()
        
        viewModel.fetchArticles(refresh: true)
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .systemBackground
        setupTableView()
        viewModel.assignDelegate(as: self)
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    fileprivate func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc fileprivate func refreshNews(refreshControl: UIRefreshControl) {
        viewModel.fetchArticles(refresh: true)
        refreshControl.endRefreshing()
    }
    
    func getNewsViewModel() -> NewsViewModel {
        return viewModel
    }
    
    func assignNewsWebViewLoadingDelegate(as delegate: LoadingNewsWebView) {
        newsWebViewLoadingDelegate = delegate
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsArticlesCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }

        guard let articleData = viewModel.newsArticleAt(index: indexPath.row) else {
            return UITableViewCell()
        }
        if let imageURL = articleData.urlToImage {
            viewModel.fetchImage(withURL: imageURL, forCellAt: indexPath)
        }
        cell.set(data: articleData)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let articleData = viewModel.newsArticleAt(index: indexPath.row) else {
            return
        }
        guard let webURL = articleData.url else {
            return
        }
        let webView = WebView()
        webView.webURL = webURL
        newsWebViewLoadingDelegate?.loadNewsWebView(webView)
    }
}

private typealias NewsViewDelegateConformance = NewsViewController
extension NewsViewDelegateConformance: NewsViewDelegate {
    func getTableView() -> UITableView {
        
        return self.tableView
    }
    
    func reloadNewsView() {
        DispatchQueue.main.async {
            print(self.viewModel.newsArticlesCount())
            self.tableView.reloadData()
        }
    }
    
    func setImage(forCellAt indexPath: IndexPath, withURL url: String, withData imageData: Data) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsCell else {
            return
        }
        if cell.imageURL == url {
            cell.image.image = UIImage(data: imageData)
        } else {
            cell.image.image = UIImage(named: "image_not_found")
        }
    }
}
