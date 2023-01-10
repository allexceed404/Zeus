//
//  FilterPage.swift
//  Zeus
//
//  Created by Priyanshu Verma on 02/01/23.
//

import UIKit

protocol PassingFilter {
    var filter: Set<Int> { get set }
    func passFilter(filter: Set<Int>)
}

protocol SettingCategoryCell {
    func setupCells(filter: Set<Int>)
}

class FilterPage: UIViewController {
    
    var filterDelegate: PassingFilter?
    var categoryCellDelegate: SettingCategoryCell?
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(localized: "categories")
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .label
        button.layer.cornerRadius = 10
        return button
    }()
    
    let categoryTable: CategoryListTableViewController = {
        let table = CategoryListTableViewController()
        table.tableView.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.setTitle(String(localized: "apply_filter"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 24
        
        addSubviews()
        addSubviewConstraints()
        
        applyButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeFilter), for: .touchUpInside)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(categoryTable.tableView)
        view.addSubview(applyButton)
    }
    
    fileprivate func addSubviewConstraints() {
        addTitleLabelConstraints()
        addCloseButtonConstraints()
        addCategoryTableConstraints()
        addApplyButtonConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        setupCategoryTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoryTable.filter = self.filterDelegate?.filter ?? []
    }
    
    fileprivate func setupCategoryTable() {
        self.categoryCellDelegate = categoryTable
        categoryCellDelegate?.setupCells(filter: filterDelegate?.filter ?? [])
    }
    
    @objc fileprivate func applyFilter() {
        var filter: Set<Int> = []
        for i in 0..<UtilityClass.categories.count {
            if let cell = categoryTable.tableView.cellForRow(at: [0, i]) as? CategoryCell {
                if cell.optIn {
//                    guard let category = cell.categoryName.text else {
//                        continue
//                    }
                    filter.insert(i)
                }
            }
        }
        filterDelegate?.passFilter(filter: filter)
        dismiss(animated: true)
    }
    
    @objc fileprivate func closeFilter() {
        dismiss(animated: true)
    }
    
    fileprivate func addTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func addCloseButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        
        closeButton.imageView?.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor).isActive = true
        closeButton.imageView?.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        closeButton.imageView?.widthAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 0.65).isActive = true
        closeButton.imageView?.heightAnchor.constraint(equalTo: closeButton.heightAnchor, multiplier: 0.65).isActive = true
    }
    
    fileprivate func addCategoryTableConstraints() {
        categoryTable.tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18).isActive = true
        categoryTable.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        categoryTable.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        categoryTable.tableView.bottomAnchor.constraint(equalTo: applyButton.topAnchor, constant: -12).isActive = true
    }

    fileprivate func addApplyButtonConstraints() {
        applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
