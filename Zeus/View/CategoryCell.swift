////
////  CategoryCell.swift
////  Zeus
////
////  Created by Priyanshu Verma on 02/01/23.
////
//
//import UIKit
//
//final class CategoryCell: UITableViewCell {
//
//    var optIn: Bool = false
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = .none
//        addSubviews()
//        addSubviewConstraints()
//    }
//    
//    fileprivate func addSubviews() {
//        addSubview(categoryName)
//        addSubview(selectedImage)
//    }
//    
//    fileprivate func addSubviewConstraints() {
//        addSelectedImageConstraints()
//        addCategoryNameConstraints()
//    }
//    
//    var categoryName: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 18, weight: .regular)
//        label.textColor = .label
//        return label
//    }()
//    
//    var selectedImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(systemName: "circle")
//        imageView.tintColor = .label
//        return imageView
//    }()
//    
//    fileprivate func addCategoryNameConstraints() {
//        categoryName.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        categoryName.leadingAnchor.constraint(equalTo: selectedImage.trailingAnchor, constant: 8).isActive = true
////        categoryName.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
////        categoryName.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//    }
//    
//    fileprivate func addSelectedImageConstraints() {
//        selectedImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        selectedImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//    }
//    
//    func setName(name: String) {
//        self.categoryName.text = name
//    }
//    
//    func setOptIn(optIn: Bool) {
//        self.optIn = optIn
//        if self.optIn {
//            categoryName.font = .systemFont(ofSize: 18, weight: .bold)
//            selectedImage.image = UIImage(systemName: "checkmark.circle.fill")
//        } else {
//            categoryName.font = .systemFont(ofSize: 18, weight: .regular)
//            selectedImage.image = UIImage(systemName: "circle")
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
