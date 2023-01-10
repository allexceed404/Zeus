//
//  NoResultsFound.swift
//  Zeus
//
//  Created by Priyanshu Verma on 06/01/23.
//

import UIKit

class NoResultsFound: UIViewController {
    private let noResultsFoundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "exclamationmark.triangle")
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let noResultsFoundLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(localized: "no_results_found")
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .systemBackground
        
        addSubviews()
        addSubviewConstraints()
    }
    
    fileprivate func addSubviews() {
        view.addSubview(noResultsFoundImage)
        view.addSubview(noResultsFoundLabel)
    }
    
    fileprivate func addSubviewConstraints() {
        addNoResultsFoundImageConstraints()
        addNoResultsFoundLabelConstraints()
    }
    
    fileprivate func addNoResultsFoundImageConstraints() {
        noResultsFoundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noResultsFoundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noResultsFoundImage.widthAnchor.constraint(equalTo: noResultsFoundLabel.heightAnchor).isActive = true
        noResultsFoundImage.heightAnchor.constraint(equalTo: noResultsFoundLabel.heightAnchor).isActive = true
    }
    
    fileprivate func addNoResultsFoundLabelConstraints() {
        noResultsFoundLabel.topAnchor.constraint(equalTo: noResultsFoundImage.bottomAnchor, constant: 8).isActive = true
        noResultsFoundLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        noResultsFoundLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        noResultsFoundLabel.heightAnchor.constraint(equalToConstant: noResultsFoundLabel.intrinsicContentSize.height).isActive = true
    }
    
    func setLabelText(toText: String) {
        noResultsFoundLabel.text = toText
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
