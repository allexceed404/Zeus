//
//  TopHeadlinesViewController.swift
//  Zeus
//
//  Created by Priyanshu Verma on 15/01/23.
//

import UIKit

final class TopHeadlinesViewController: UIViewController, LoadingNewsWebView, WebEvents, WebEventsDelegate, FilterEvents, FilterEventsDelegate {
    
    private let viewTitle: GenericLabel = {
        let label = GenericLabel(frame: .zero, text: String(localized: "top_headlines"), textColor: .label, textSize: 32)
        return label
    }()
    
    internal let filterButton: GenericButton = {
        let button = GenericButton(frame: .zero, systemImage: "checklist", tintColor: .black, backgroundColor: .systemYellow)
        return button
    }()
    
    internal let newsView = NewsViewController()
    private var newsViewModel: NewsViewModel?
    
    internal var loadingScreen = LoadingScreen()
    internal var noResultsScreen = NoResultsFound()
    internal var noInternetScreen = NoInternetConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        addSubviewConstraints()
        
        newsView.assignNewsWebViewLoadingDelegate(as: self)
        newsViewModel = newsView.getNewsViewModel()
        newsViewModel?.assignWebEventsDelegate(as: self)
        
        setScreenConstraints(superView: view, tableView: newsView.tableView, view: loadingScreen.view)
        setScreenConstraints(superView: view, tableView: newsView.tableView, view: noResultsScreen.view)
        setScreenConstraints(superView: view, tableView: newsView.tableView, view: noInternetScreen.view)
        
        filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
    }
    
    func setTitle(to title: String) {
        viewTitle.text = title
    }
    
    func getNewsViewModel() -> NewsViewModel? {
        return newsView.getNewsViewModel()
    }
    
    @objc func filterButtonAction() {
        goToFilter(filterEventsDelegate: self, filterType: .category, filter: newsViewModel?.getCategories() ?? [])
    }
    
    func applyFilter(as filter: [String]) {
        newsViewModel?.setCategories(to: filter)
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(viewTitle)
        view.addSubview(filterButton)
        view.addSubview(newsView.tableView)
    }

    fileprivate func addSubviewConstraints() {
        addViewTitleConstraints()
        addFilterButtonConstraints()
        addNewsViewConstraints()
    }
    
    fileprivate func addViewTitleConstraints() {
        viewTitle.centerYAnchor.constraint(equalTo: filterButton.centerYAnchor).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8).isActive = true
        viewTitle.heightAnchor.constraint(equalToConstant: viewTitle.intrinsicContentSize.height).isActive = true
    }
    
    fileprivate func addFilterButtonConstraints() {
        filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        filterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        filterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        filterButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    fileprivate func addNewsViewConstraints() {
        newsView.tableView.translatesAutoresizingMaskIntoConstraints = false
        newsView.tableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 12).isActive = true
        newsView.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        newsView.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        newsView.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
