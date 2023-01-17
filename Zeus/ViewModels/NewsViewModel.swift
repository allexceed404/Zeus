//
//  NewsViewModel.swift
//  Zeus
//
//  Created by Priyanshu Verma on 12/01/23.
//

import Foundation
import UIKit

protocol NewsViewDelegate {
    func getTableView() -> UITableView
    func reloadNewsView()
    func setImage(forCellAt indexPath: IndexPath, withURL url: String, withData imageData: Data)
}

final class NewsViewModel {
    
    private var delegate: NewsViewDelegate?
    private var webEventsDelegate: WebEventsDelegate?
    
    private var endpoint: UtilityClass.APIEndpoint = .headlines
    private var categories: [String]?
    private var sources: [String]?
    private var country: String?
    private var language: String? = "en"
    private var keyword: String?
    private var searchIn: [String]?
    private let pageSize = 20
    private var pageNumber = 1
    
    private var newsArticles: [Articles] = [] {
        didSet {
            if newsArticles.count != 0 {
                webEventsDelegate?.show(tableView: delegate?.getTableView(), showTable: true, loading: false, noResults: false, noInternet: false)
                delegate?.reloadNewsView()
            } else {
                webEventsDelegate?.show(tableView: delegate?.getTableView(), showTable: false, loading: false, noResults: true, noInternet: false)
            }
        }
    }
    private let newsArticlesLimit = 100
    
    func assignDelegate(as delegate: NewsViewDelegate) {
        self.delegate = delegate
    }
    
    func assignWebEventsDelegate(as delegate: WebEventsDelegate) {
        self.webEventsDelegate = delegate
    }
    
    func newsArticlesCount() -> Int {
        return newsArticles.count
    }
    
    func newsArticleAt(index: Int) -> Articles? {
        if (newsArticles.count > index) {
            if(pageNumber*pageSize<newsArticlesLimit && index>=(pageNumber*pageSize - pageSize/2)) {
                self.fetchArticles(nextPage: true)
            }
            return newsArticles[index]
        } else {
            return nil
        }
    }
    
    func fetchArticles(refresh: Bool = false, nextPage: Bool = false) {
        if refresh {
            newsArticles = []
            pageNumber = 1
            webEventsDelegate?.show(tableView: delegate?.getTableView(), showTable: false, loading: true, noResults: false, noInternet: false)
        }
        if nextPage {
            pageNumber += 1
        }
        Networking.sharedInstance.getNewsArticles(via: endpoint, for: categories, from: sources, forCountry: country, in: language, with: keyword, searchIn: searchIn, pageSize: pageSize, pageNumber: pageNumber) {[weak self] result in
            switch result {
            case .success(let apiResponse):
                guard let fetchedNewsArticles = apiResponse.articles else {
                    return
                }
                
                if let newsArticles = self?.newsArticles {
                    self?.newsArticles = newsArticles + fetchedNewsArticles
                } else {
                    self?.newsArticles = fetchedNewsArticles
                }
            case .failure(let error):
                switch error {
                case .NoDataAvailable:
                    self?.webEventsDelegate?.show(tableView: self?.delegate?.getTableView(), showTable: false, loading: false, noResults: true, noInternet: false)
                case .NoInternetConnection:
                    self?.webEventsDelegate?.show(tableView: self?.delegate?.getTableView(), showTable: false, loading: false, noResults: false, noInternet: true)
                default:
                    print(error)
                }
            }
        }
    }
    
    func fetchImage(withURL url: String, forCellAt indexPath: IndexPath) {
        Networking.sharedInstance.getImage(urlString: url){[weak self] imageData in
            switch imageData{
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.delegate?.setImage(forCellAt: indexPath, withURL: url, withData: imageData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setEndpoint(to endpoint: UtilityClass.APIEndpoint) {
        self.endpoint = endpoint
    }
    
    func setCategories(to categories: [String]) {
        self.categories = categories
        fetchArticles(refresh: true)
    }
    
    func getCategories() -> [String] {
        if let categories {
            return categories
        } else {
            return []
        }
    }
    
    func setSources(to sources: [String]) {
        self.sources = sources
        fetchArticles(refresh: true)
    }
    
    func getSources() -> [String] {
        if let sources {
            return sources
        } else {
            return []
        }
    }
    
    func setCountry(to country: String) {
        self.country = country
        self.language = nil
        fetchArticles(refresh: true)
    }
    
    func setLanguage(to language: String) {
        self.language = language
        fetchArticles(refresh: true)
    }
    
    func setKeyword(to keyword: String) {
        guard let lastKeyword = self.keyword else {
            self.keyword = keyword
            fetchArticles(refresh: true)
            return
        }
        if keyword == lastKeyword {
            return
        } else {
            if keyword.count == 0 {
                self.endpoint = .headlines
                fetchArticles(refresh: true)
                return
            }
            self.keyword = keyword
            fetchArticles(refresh: true)
        }
    }
    
    func setSearchIn(to searchIn: [String]) {
        self.searchIn = searchIn
        fetchArticles(refresh: true)
    }
}
