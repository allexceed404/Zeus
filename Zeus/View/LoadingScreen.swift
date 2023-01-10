//
//  LoadingScreen.swift
//  Zeus
//
//  Created by Priyanshu Verma on 06/01/23.
//

import UIKit

class LoadingScreen: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.animationImages = []
        var imageNamePrefix: String
        if UIScreen.main.traitCollection.userInterfaceStyle == .light {
            imageNamePrefix = "frame-"
        } else {
            imageNamePrefix = "bframe-"
        }
        for i in 1...20 {
            if let image = UIImage(named: imageNamePrefix + String(i)) {
                imageView.animationImages?.append(image)
            }
        }
        imageView.tintColor = .systemYellow
        imageView.animationDuration = 0.5
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        imageView.isOpaque = true
        imageView.startAnimating()
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        imageView.stopAnimating()
        imageView.animationImages = []
        var imageNamePrefix: String
        if UIScreen.main.traitCollection.userInterfaceStyle == .light {
            imageNamePrefix = "frame-"
        } else {
            imageNamePrefix = "bframe-"
        }
        for i in 1...20 {
            if let image = UIImage(named: imageNamePrefix + String(i)) {
                imageView.animationImages?.append(image)
            }
        }
        imageView.startAnimating()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .systemBackground
        
        addSubviews()
        addSubviewConstraints()
    }
    
    fileprivate func addSubviews() {
        view.addSubview(imageView)
    }
    
    fileprivate func addSubviewConstraints() {
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
