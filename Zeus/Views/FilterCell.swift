//
//  FilterCell.swift
//  Zeus
//
//  Created by Priyanshu Verma on 16/01/23.
//

import UIKit

final class FilterCell: UITableViewCell {
    private let backgroundCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let cellName: GenericLabel = {
        let label = GenericLabel(frame: .zero, text: "", textColor: .label, textSize: 20)
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let selectedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark.circle")
        imageView.tintColor = .black
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addSubviews()
        addSubviewConstraints()
    }
    
    fileprivate func addSubviews() {
        addSubview(backgroundCard)
        backgroundCard.addSubview(cellName)
        backgroundCard.addSubview(selectedImage)
        selectedImage.isHidden = true
    }
    
    fileprivate func addSubviewConstraints() {
        addBackgroundCardConstraints()
        addCellNameConstraints()
        addSelectedImageConstraints()
    }
    
    fileprivate func addBackgroundCardConstraints() {
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
    }
    
    fileprivate func addCellNameConstraints() {
        cellName.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 4).isActive = true
        cellName.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 8).isActive = true
        cellName.trailingAnchor.constraint(equalTo: selectedImage.leadingAnchor, constant: -8).isActive = true
        cellName.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -4).isActive = true
    }
    
    fileprivate func addSelectedImageConstraints() {
        selectedImage.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -8).isActive = true
        selectedImage.topAnchor.constraint(equalTo: cellName.topAnchor).isActive = true
        selectedImage.heightAnchor.constraint(equalTo: cellName.heightAnchor).isActive = true
        selectedImage.widthAnchor.constraint(equalTo: cellName.heightAnchor).isActive = true
    }
    
    func setCellName(to text: String) {
        cellName.text = String(localized: LocalizedStringResource(stringLiteral: text))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            backgroundCard.backgroundColor = .systemYellow
            selectedImage.isHidden = false
            cellName.font = .systemFont(ofSize: 20, weight: .bold)
            cellName.textColor = .black
        } else {
            backgroundCard.backgroundColor = .systemBackground
            selectedImage.isHidden = true
            cellName.font = .systemFont(ofSize: 20, weight: .regular)
            cellName.textColor = .label
        }
    }

}
