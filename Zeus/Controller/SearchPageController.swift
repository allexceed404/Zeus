//
//  SearchPageController.swift
//  Zeus
//
//  Created by Priyanshu Verma on 29/12/22.
//

import UIKit

class SearchPageController: UIViewController, PassingFilter {
    
    var viewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(localized: "search")
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    var searchBar: UITextField = {
        let tf = UITextField()
        setupTextField(tf, placeholder: String(localized: "search_example"))
        tf.clipsToBounds = true
        return tf
    }()
    
    var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "checklist"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemYellow
        return button
    }()
    
    private var previousSourcesFilter = ""
    private var sourcesFilter = "" {
        didSet {
            DispatchQueue.main.async {
                self.applySearch(fromDebouncer: false)
            }
        }
    }
    
    var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemYellow
        return button
    }()
    
    private var lastSearchedTerm = ""
    
    var debounceTimer: Timer?
    
    var newsView: NewsView = {
        let view = NewsView()
        view.tableView.translatesAutoresizingMaskIntoConstraints = false
//        view.title = "Search page news view"
        return view
    }()
    
    private let loadingScreen = LoadingScreen()
    private let noResultsFoundScreen = NoResultsFound()
    private let noInternetConnectionScreen = NoInternetConnection()
    
//    let categories = [
//        String(localized: "business"),
//        String(localized: "entertainment"),
//        String(localized: "general"),
//        String(localized: "health"),
//        String(localized: "science"),
//        String(localized: "sports"),
//        String(localized: "technology")
//    ]
//
//    let categoriesLocalisationMap = [
//        String(localized: "business"): "Business",
//        String(localized: "entertainment"): "Entertainment",
//        String(localized: "general"): "General",
//        String(localized: "health"): "Health",
//        String(localized: "science"): "Science",
//        String(localized: "sports"): "Sports",
//        String(localized: "technology"): "Technology"
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if newsView.tableView.isHidden {
            newsView.refreshTableView()
        }
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        
        addSubviews()
        addSubviewConstraints()
        
        loadingScreen.view.isHidden = true
        noResultsFoundScreen.view.isHidden = true
        noInternetConnectionScreen.view.isHidden = true
//        searchBar
        searchBar.delegate = self
        newsView.newsEventsDelegate = self
        noInternetConnectionScreen.refreshDelegate = self
        filterButton.addTarget(self, action: #selector(goToFilter), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(applySearch), for: .touchUpInside)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(viewTitle)
        view.addSubview(searchBar)
        view.addSubview(filterButton)
        view.addSubview(searchButton)
        view.addSubview(newsView.tableView)
        view.addSubview(loadingScreen.view)
        view.addSubview(noResultsFoundScreen.view)
        view.addSubview(noInternetConnectionScreen.view)
    }
    
    fileprivate func addSubviewConstraints() {
        addViewTitleConstraints()
        addSearchBarConstraints()
        addFilterButtonConstraints()
        addSearchButtonConstraints()
        addNewsViewConstraints()
        
        addConstraintsTo(loadingScreen.view)
        addConstraintsTo(noResultsFoundScreen.view)
        addConstraintsTo(noInternetConnectionScreen.view)
//        addLoadingScreenConstraints()
//        addNoResultsFoundScreenConstraints()
    }
    
    fileprivate func addViewTitleConstraints() {
        viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        viewTitle.heightAnchor.constraint(equalToConstant: viewTitle.intrinsicContentSize.height).isActive = true
    }
    
    fileprivate func addSearchBarConstraints() {
        searchBar.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 12).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    fileprivate func addFilterButtonConstraints() {
        filterButton.topAnchor.constraint(equalTo: searchBar.topAnchor).isActive = true
        filterButton.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8).isActive = true
        filterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        filterButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    fileprivate func addSearchButtonConstraints() {
        searchButton.topAnchor.constraint(equalTo: searchBar.topAnchor).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    fileprivate func addNewsViewConstraints() {
        newsView.tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12).isActive = true
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
    
    @objc func goToFilter() {
        let filterScreen = SearchPageFilter()
        filterScreen.sourcesFilterDelegate = self
        self.navigationController?.present(filterScreen, animated: true)
        view.snapshotView(afterScreenUpdates: true)
    }
    
    @objc func applySearch(fromDebouncer: Bool) {
        if !fromDebouncer {
            searchBar.resignFirstResponder()
        }
        if let searchText = searchBar.text {
            if searchText == lastSearchedTerm && sourcesFilter == previousSourcesFilter {
                return
            }
            lastSearchedTerm = searchText
            previousSourcesFilter = sourcesFilter
            if searchText.count == 0 && sourcesFilter.count == 0 {
                return
            }
            newsView.baseQuery = "everything?apiKey=" + Secrets.apiKey.rawValue
            let query = searchText.replacingOccurrences(of: " ", with: "%20")
            filterString = filterString + "&q=" + query + sourcesFilter
        }
        else {
            print(1)
            newsView.baseQuery = "top-headlines?language=en&apiKey=" + Secrets.apiKey.rawValue
        }
        newsView.setQuery(filter: filterString)
        filterString = ""
    }
    
    // MARK: - PassingFilter Conformation
    
    var filterString = ""
    var filter: Set<Int> = [] {
        didSet {
            var filterString = ""
            for index in filter {
                if let category = UtilityClass.categoriesLocalisationMap[UtilityClass.categories[index]] {
                    filterString.append("&category=\(category.lowercased())")
                }
            }
            self.filterString = filterString
        }
    }
    
    func passFilter(filter: Set<Int>) {
        self.filter = filter
    }
    
}

fileprivate func setupTextField(_ textField: UITextField, placeholder: String) {
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = placeholder
    textField.keyboardType = UIKeyboardType.default
    textField.returnKeyType = UIReturnKeyType.done
    textField.autocorrectionType = UITextAutocorrectionType.no
    textField.font = UIFont.systemFont(ofSize: 20)
    textField.textColor = UIColor.label
    textField.tintColor = UIColor.secondaryLabel
    textField.attributedPlaceholder = NSAttributedString(
        string: placeholder,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
    textField.borderStyle = UITextField.BorderStyle.roundedRect
    textField.layer.borderColor = UIColor.label.cgColor
    textField.layer.borderWidth = 0.5
    textField.layer.cornerRadius = 10
    textField.clearButtonMode = UITextField.ViewMode.whileEditing
    textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    textField.backgroundColor = .tertiarySystemFill
}

private typealias HandlingSearchBarTextFieldEvents = SearchPageController
extension HandlingSearchBarTextFieldEvents: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Began editing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print(reason)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        searchBar.resignFirstResponder()
        applySearch(fromDebouncer: false)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {[weak self] _ in
            self?.applySearch(fromDebouncer: true)
        }
        print("Debounce Timer: ", debounceTimer?.timeInterval ?? "Not Found")
    }
}

private typealias LoadWebViewOnSearchPage = SearchPageController
extension LoadWebViewOnSearchPage: HandleNewsViewEvents {
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

private typealias ReCheckNetworkConnectivity = SearchPageController
extension ReCheckNetworkConnectivity: TryRefreshNews {
    func refreshNews() {
        newsView.refreshTableView()
    }
}

private typealias SetSourcesFilter = SearchPageController
extension SetSourcesFilter: PassingSourcesFilter {
    func passSourcesFilter(filterWith filter: String) {
        sourcesFilter = filter
    }
}
