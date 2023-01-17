//
//  GenericLabel.swift
//  Zeus
//
//  Created by Priyanshu Verma on 15/01/23.
//

import UIKit

final class GenericLabel: UILabel {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, text: String, textColor: UIColor, textSize: CGFloat) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        font = .systemFont(ofSize: textSize, weight: .bold)
        self.textColor = textColor
    }
}
