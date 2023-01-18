//
//  GenericButton.swift
//  Zeus
//
//  Created by Priyanshu Verma on 15/01/23.
//

import UIKit

final class GenericButton: UIButton {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, systemImage: String, tintColor: UIColor, backgroundColor: UIColor, text: String? = nil) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(systemName: systemImage), for: .normal)
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.contentMode = .scaleAspectFill
        layer.cornerRadius = 10
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        if let text {
            setTitle(text, for: .normal)
        }
        titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        setTitleColor(.black, for: .normal)
        titleLabel?.textAlignment = .center
        addImageViewContraints()
        if let titleLabel {
            imageView?.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -8).isActive = true
        } else {
            imageView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
    }
    
    fileprivate func addImageViewContraints() {
        imageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView?.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65).isActive = true
        imageView?.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.65).isActive = true
    }
}
