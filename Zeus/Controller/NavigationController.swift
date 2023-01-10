//
//  NavigationController.swift
//  Zeus
//
//  Created by Priyanshu Verma on 30/12/22.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.label]
        navigationBar.largeTitleTextAttributes = textAttributes
    }
    
}
