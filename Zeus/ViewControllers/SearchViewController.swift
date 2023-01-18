//
//  SearchViewController.swift
//  Zeus
//
//  Created by Priyanshu Verma on 16/01/23.
//

import UIKit

final class SearchViewController: UIViewController, LoadingNewsWebView, WebEvents, WebEventsDelegate, FilterEvents, FilterEventsDelegate {
    private let viewTitle: GenericLabel = {
        let label = GenericLabel(frame: .zero, text: String(localized: "search"), textColor: .label, textSize: 32)
        return label
    }()
    
    internal let filterButton: GenericButton = {
        let button = GenericButton(frame: .zero, systemImage: "checklist", tintColor: .black, backgroundColor: .systemYellow)
        return button
    }()
    
    private let searchField: GenericTextField = {
        let textField = GenericTextField(frame: .zero, placeholderText: String(localized: "search_example"), textSize: 20)
        return textField
    }()
    private var debounceTimer: Timer?
    
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
        
        searchField.delegate = self
        newsView.assignNewsWebViewLoadingDelegate(as: self)
        newsViewModel = newsView.getNewsViewModel()
        newsViewModel?.assignWebEventsDelegate(as: self)
        
        setScreenConstraints(superView: view, tableView: newsView.tableView, view: loadingScreen.view)
        setScreenConstraints(superView: view, tableView: newsView.tableView, view: noResultsScreen.view)
        setScreenConstraints(superView: view, tableView: newsView.tableView, view: noInternetScreen.view)
        
        filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
    }
    
    @objc func filterButtonAction() {
        goToFilter(filterEventsDelegate: self, filterType: .source, filter: newsViewModel?.getSources() ?? [])
    }
    
    func applyFilter(as filter: [String]) {
        newsViewModel?.setSources(to: filter)
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(viewTitle)
        view.addSubview(filterButton)
        view.addSubview(searchField)
        view.addSubview(newsView.tableView)
    }

    fileprivate func addSubviewConstraints() {
        addViewTitleConstraints()
        addFilterButtonConstraints()
        addSearchFieldConstraints()
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
    
    fileprivate func addSearchFieldConstraints() {
        searchField.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 12).isActive = true
        searchField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        searchField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: searchField.intrinsicContentSize.height).isActive = true
    }
    
    fileprivate func addNewsViewConstraints() {
        newsView.tableView.translatesAutoresizingMaskIntoConstraints = false
        newsView.tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 12).isActive = true
        newsView.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        newsView.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        newsView.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

private typealias SearchFieldDelegation = SearchViewController
extension SearchFieldDelegation: UITextFieldDelegate {
    func applySearch(fromDebouncer: Bool) {
       if !fromDebouncer {
           searchField.resignFirstResponder()
       }
        guard var searchKeyword = searchField.text else {
            return
        }
        searchKeyword = searchKeyword.replacingOccurrences(of: " ", with: "%20")
        newsViewModel?.setEndpoint(to: .everything)
        newsViewModel?.setKeyword(to: searchKeyword)
   }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        applySearch(fromDebouncer: false)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {[weak self] _ in
            self?.applySearch(fromDebouncer: true)
        }
    }
}
