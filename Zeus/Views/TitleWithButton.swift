//
//  TitleWithButton.swift
//  Zeus
//
//  Created by Priyanshu Verma on 15/01/23.
//

import UIKit

final class TitleWithButton: UIView {
    private var title: GenericLabel?
    private var button: GenericButton?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupTitle(text: String, textColor: UIColor, textSize: CGFloat) {
        title = GenericLabel(frame: .zero, text: text, textColor: textColor, textSize: textSize)
    }
    
    func setupButton(systemImage: String, tintColor: UIColor, backgroundColor: UIColor) {
        button = GenericButton(frame: .zero, systemImage: systemImage, tintColor: tintColor, backgroundColor: backgroundColor)
    }
    
    func setupView() {
        guard let title else {
            return
        }
        guard let button else {
            return
        }
        
        addSubview(title)
        addSubview(button)
        addTitleConstraints()
        addButtonConstraints()
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: button.frame.height).isActive = true
    }
    
    fileprivate func addTitleConstraints() {
        guard let title else {
            return
        }
        
        title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: title.intrinsicContentSize.height).isActive = true
        
        if let button {
            title.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
            title.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -8).isActive = true
        } else {
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
    }
    
    fileprivate func addButtonConstraints() {
        guard let button else {
            return
        }
        button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
