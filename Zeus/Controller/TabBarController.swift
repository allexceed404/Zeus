////
////  TabBarController.swift
////  Zeus
////
////  Created by Priyanshu Verma on 29/12/22.
////
//
//import UIKit
//
//final class TabBarController: UITabBarController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTabs()
//        setupLayout()
//    }
//    
//    fileprivate func setupTabs() {
//        let topNewsPage = HeadlinesViewController()
//        topNewsPage.tabBarItem = UITabBarItem(title: String(localized: "top_headlines"), image: UIImage(systemName: "bolt"), selectedImage: UIImage(systemName: "bolt.fill"))
//        
//        let mapPage = MapPageController()
//        mapPage.tabBarItem = UITabBarItem(title: String(localized: "map"), image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
//        
//        let searchPage = SearchPageController()
//        searchPage.tabBarItem = UITabBarItem(title: String(localized: "search"), image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
//        
//        viewControllers = [topNewsPage, mapPage, searchPage]
//    }
//    
//    fileprivate func setupLayout() {
//        tabBar.isTranslucent = false
//        tabBar.tintColor = .systemYellow
//        tabBar.barTintColor = .black
//        tabBar.backgroundColor = .black
//    }
//
//}
