//
//  WebEvents.swift
//  Zeus
//
//  Created by Priyanshu Verma on 16/01/23.
//

import UIKit

protocol WebEventsDelegate {
    func show(tableView: UITableView?, showTable: Bool, loading: Bool, noResults: Bool, noInternet: Bool)
}

protocol WebEvents {
    var loadingScreen: LoadingScreen {get}
    var noResultsScreen: NoResultsFound {get}
    var noInternetScreen: NoInternetConnection {get}
    
    func setScreenConstraints(superView: UIView, tableView: UITableView, view: UIView)
    func show(tableView: UITableView?, showTable: Bool, loading: Bool, noResults: Bool, noInternet: Bool)
}

extension WebEvents where Self: UIViewController {
    func setScreenConstraints(superView: UIView, tableView: UITableView, view: UIView) {
        superView.addSubview(view)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
    }
    
    func show(tableView: UITableView?, showTable: Bool = false, loading: Bool = false, noResults: Bool = false, noInternet: Bool = false) {
        print("Web Events Delegate!")
        DispatchQueue.main.async {
            if let tableView {
                tableView.isHidden = !showTable
            }
            self.loadingScreen.view.isHidden = !loading
            self.noResultsScreen.view.isHidden = !noResults
            self.noInternetScreen.view.isHidden = !noInternet
        }
    }
}
