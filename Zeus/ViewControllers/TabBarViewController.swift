//
//  TabBarViewController.swift
//  Zeus
//
//  Created by Priyanshu Verma on 12/01/23.
//

import UIKit

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTabs()
    }
    
    fileprivate func setupLayout() {
        tabBar.isTranslucent = false
        tabBar.tintColor = .systemYellow
        tabBar.barTintColor = .black
        tabBar.backgroundColor = .black
    }
    
    fileprivate func setupTabs() {
        let headlinesPage = TopHeadlinesViewController()
        headlinesPage.tabBarItem = UITabBarItem(title: String(localized: "top_headlines"), image: UIImage(systemName: "bolt"), selectedImage: UIImage(systemName: "bolt.fill"))
        
        let mapPage = MapViewController()
        mapPage.tabBarItem = UITabBarItem(title: String(localized: "map"), image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        
        let searchPage = SearchViewController()
        searchPage.tabBarItem = UITabBarItem(title: String(localized: "search"), image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        viewControllers = [headlinesPage, mapPage, searchPage]
    }
}
