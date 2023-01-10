//
//  NoInternetConnection.swift
//  Zeus
//
//  Created by Priyanshu Verma on 09/01/23.
//

import UIKit

protocol TryRefreshNews {
    func refreshNews()
}

class NoInternetConnection: UIViewController {
    private let noInternetConnectionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "wifi.slash")
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let noInternetConnectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(localized: "no_internet_connection")
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    var refreshDelegate: TryRefreshNews?
    
    private let retryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.clockwise.circle"), for: .normal)
        button.backgroundColor = .systemYellow
        button.tintColor = .black
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .systemBackground
        
        addSubviews()
        addSubviewConstraints()
        
        retryButton.addTarget(self, action: #selector(retryNetworkConnection), for: .touchUpInside)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(noInternetConnectionImage)
        view.addSubview(noInternetConnectionLabel)
        view.addSubview(retryButton)
    }
    
    fileprivate func addSubviewConstraints() {
        addNoInternetConnectionImageConstraints()
        addNoInternetConnectionLabelConstraints()
        addRetryButtonConstraints()
    }
    
    fileprivate func addNoInternetConnectionLabelConstraints() {
        noInternetConnectionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noInternetConnectionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noInternetConnectionLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        noInternetConnectionLabel.heightAnchor.constraint(equalToConstant: noInternetConnectionLabel.intrinsicContentSize.height).isActive = true
        
//        noInternetConnectionLabel.topAnchor.constraint(equalTo: noInternetConnectionImage.bottomAnchor, constant: 8).isActive = true
//        noInternetConnectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        noInternetConnectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        noInternetConnectionLabel.heightAnchor.constraint(equalToConstant: noInternetConnectionLabel.intrinsicContentSize.height).isActive = true
    }
    
    fileprivate func addNoInternetConnectionImageConstraints() {
        noInternetConnectionImage.bottomAnchor.constraint(equalTo: noInternetConnectionLabel.topAnchor, constant: -8).isActive = true
        noInternetConnectionImage.centerXAnchor.constraint(equalTo: noInternetConnectionLabel.centerXAnchor).isActive = true
        noInternetConnectionImage.heightAnchor.constraint(equalTo: noInternetConnectionLabel.heightAnchor).isActive = true
        noInternetConnectionImage.widthAnchor.constraint(equalTo: noInternetConnectionLabel.heightAnchor).isActive = true
        
//        noInternetConnectionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        noInternetConnectionImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        noInternetConnectionImage.widthAnchor.constraint(equalTo: noInternetConnectionLabel.heightAnchor).isActive = true
//        noInternetConnectionImage.heightAnchor.constraint(equalTo: noInternetConnectionLabel.heightAnchor).isActive = true
    }
    
    fileprivate func addRetryButtonConstraints() {
        retryButton.topAnchor.constraint(equalTo: noInternetConnectionLabel.bottomAnchor, constant: 8).isActive = true
        retryButton.centerXAnchor.constraint(equalTo: noInternetConnectionLabel.centerXAnchor).isActive = true
        retryButton.heightAnchor.constraint(equalTo: noInternetConnectionLabel.heightAnchor, multiplier: 1.5).isActive = true
        retryButton.widthAnchor.constraint(equalTo: retryButton.heightAnchor).isActive = true
        
        retryButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        retryButton.imageView?.centerXAnchor.constraint(equalTo: retryButton.centerXAnchor).isActive = true
        retryButton.imageView?.centerYAnchor.constraint(equalTo: retryButton.centerYAnchor).isActive = true
        retryButton.imageView?.heightAnchor.constraint(equalTo: retryButton.heightAnchor, multiplier: 0.75).isActive = true
        retryButton.imageView?.widthAnchor.constraint(equalTo: retryButton.widthAnchor, multiplier: 0.75).isActive = true
    }
    
    @objc func retryNetworkConnection() {
        refreshDelegate?.refreshNews()
    }
    
    func setLabelText(toText: String) {
        noInternetConnectionLabel.text = toText
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
