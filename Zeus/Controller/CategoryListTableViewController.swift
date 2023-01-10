//
//  CategoryListTableViewController.swift
//  Zeus
//
//  Created by Priyanshu Verma on 02/01/23.
//

import UIKit

class CategoryListTableViewController: TableViewController {

//    let categories = [
//        String(localized: "business"),
//        String(localized: "entertainment"),
//        String(localized: "general"),
//        String(localized: "health"),
//        String(localized: "science"),
//        String(localized: "sports"),
//        String(localized: "technology")
//    ]
    
    var filter: Set<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        tableView.rowHeight = 35
        tableView.separatorStyle = .none
//        tableView.allowsMultipleSelection = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UtilityClass.categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell else {
            return UITableViewCell()
        }
        cell.setName(name: UtilityClass.categories[indexPath.row])
        if filter.contains(indexPath.row) {
            cell.setOptIn(optIn: true)
        } else {
            cell.setOptIn(optIn: false)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryCell else {
            return
        }
        if cell.optIn {
            cell.optIn = false
            cell.categoryName.font = .systemFont(ofSize: 18, weight: .regular)
            cell.selectedImage.image = UIImage(systemName: "circle")
        }
        else {
            cell.optIn = true
            cell.categoryName.font = .systemFont(ofSize: 18, weight: .bold)
            cell.selectedImage.image = UIImage(systemName: "checkmark.circle.fill")
        }
    }
}

private typealias SetupCategoryCells = CategoryListTableViewController
extension SetupCategoryCells: SettingCategoryCell {
    func setupCells(filter: Set<Int>) {
//        for i in 0..<categories.count {
//            guard let cell = tableView.cellForRow(at: [0, i]) as? CategoryCell else {
//                return
//            }
//            if let category = cell.categoryName.text {
//                if((filter.contains(category))) {
//                    cell.optIn = true
//                    cell.categoryName.font = .systemFont(ofSize: 18, weight: .bold)
//                    cell.selectedImage.image = UIImage(systemName: "checkmark.circle.fill")
//                }
//            }
//        }
    }
}
