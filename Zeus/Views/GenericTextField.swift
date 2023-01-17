//
//  GenericTextField.swift
//  Zeus
//
//  Created by Priyanshu Verma on 16/01/23.
//

import UIKit

final class GenericTextField: UITextField {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, placeholderText: String, textSize: CGFloat) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        placeholder = placeholderText
        keyboardType = .default
        returnKeyType = .done
        autocorrectionType = .no
        font = .systemFont(ofSize: textSize)
        textColor = .label
        tintColor = .secondaryLabel
        attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        borderStyle = .roundedRect
        layer.borderColor = UIColor.label.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 10
        clearButtonMode = .whileEditing
        contentVerticalAlignment = .center
        backgroundColor = .tertiarySystemFill
    }
}
