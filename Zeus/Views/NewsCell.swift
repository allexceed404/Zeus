//
//  NewsCell.swift
//  Zeus
//
//  Created by Priyanshu Verma on 12/01/23.
//

import UIKit

final class NewsCell: UITableViewCell {
    
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
        addSubview(image)
        addSubview(titleLabel)
        addSubview(publishedAtLabel)
        addSubview(publishedAtIcon)
        addSubview(source)
    }
    
    fileprivate func addSubviewConstraints() {
        addBackgroundCardConstraints()
        addPublishedAtLabelConstraints()
        addPublishedAtIconConstraints()
        addTitleLabelConstraints()
        addImageConstraints()
        addSourceConstraints()
    }
    
    var backgroundCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .quaternaryLabel
        view.clipsToBounds = true
        return view
    }()
    
    var imageURL = ""
    
    var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "image_not_found")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    private var debounceTimer: Timer?
    
    var source: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemYellow
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.layer.cornerRadius = 6
        label.text = String(localized: "source")
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 3
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var publishedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    var publishedAtIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .label
        return imageView
    }()
    
    fileprivate func addBackgroundCardConstraints() {
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
    }
    
    fileprivate func addImageConstraints() {
        image.topAnchor.constraint(equalTo: backgroundCard.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 9/16).isActive = true
    }
    
    fileprivate func addSourceConstraints() {
        source.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -8).isActive = true
        source.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -8).isActive = true
    }
    
    fileprivate func addTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 6).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: publishedAtLabel.topAnchor, constant: -6).isActive = true
    }
    
    fileprivate func addPublishedAtLabelConstraints() {
        publishedAtLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -8).isActive = true
        publishedAtLabel.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -8).isActive = true
    }
    
    fileprivate func addPublishedAtIconConstraints() {
        publishedAtIcon.heightAnchor.constraint(equalTo: publishedAtLabel.heightAnchor).isActive = true
        publishedAtIcon.widthAnchor.constraint(equalTo: publishedAtLabel.heightAnchor).isActive = true
        publishedAtIcon.trailingAnchor.constraint(equalTo: publishedAtLabel.leadingAnchor, constant: -2).isActive = true
        publishedAtIcon.bottomAnchor.constraint(equalTo: publishedAtLabel.bottomAnchor).isActive = true
    }
    
    func set(data: Articles) {
        titleLabel.text = data.title
        
        if let dataSource = data.source {
            if let dataSourceName = dataSource.name {
                source.text = dataSourceName + " "
            }
        }
        
        publishedAtLabel.text = makeDate(inDate: data.publishedAt)
        
        image.image = UIImage(named: "image_not_found")
        if let imageURL = data.urlToImage {
            self.imageURL = imageURL
        }
        else {
            self.imageURL = ""
        }
    }
    
    fileprivate func makeDate(inDate: String?) -> String {
        if let inDate {
            return inDate[8..<10] + "/" + inDate[5..<7] + "/" + inDate[0..<4]
        }
        else {
            return ""
        }
    }
    
}

private typealias SubstringSubscripts = String
extension SubstringSubscripts {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}
