////
////  SearchPageFilter.swift
////  Zeus
////
////  Created by Priyanshu Verma on 09/01/23.
////
//
//import UIKit
//
//protocol PassingSourcesFilter {
//    func passSourcesFilter(filterWith filter: String)
//}
//
//final class SearchPageFilter: UIViewController {
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = String(localized: "select_a_category")
//        label.font = .systemFont(ofSize: 32, weight: .heavy)
//        label.textColor = .label
//        label.textAlignment = .left
//        return label
//    }()
//    
//    private let closeButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
//        button.imageView?.contentMode = .scaleAspectFill
//        button.tintColor = .label
//        button.layer.cornerRadius = 10
//        return button
//    }()
//    
//    private let categoryTable: ModifiedCategoryTableView = {
//        let table = ModifiedCategoryTableView()
//        table.tableView.translatesAutoresizingMaskIntoConstraints = false
//        return table
//    }()
//    
//    private let sourceTable: SourcesView = {
//        let table = SourcesView()
//        table.tableView.translatesAutoresizingMaskIntoConstraints = false
//        return table
//    }()
//    
//    private let applyButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 16
//        button.setTitle(String(localized: "apply_filter"), for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
//        button.backgroundColor = .systemYellow
//        button.setTitleColor(.black, for: .normal)
//        return button
//    }()
//    
//    var sourcesFilterDelegate: PassingSourcesFilter?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//    }
//    
//    fileprivate func setupViews() {
//        view.backgroundColor = .systemBackground
//        view.layer.cornerRadius = 24
//        
//        addSubviews()
//        addSubviewConstraints()
//        
//        sourceTable.tableView.isHidden = true
//        applyButton.isHidden = true
//        
//        categoryTable.categoryDelegate = self
//        
//        applyButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
//        closeButton.addTarget(self, action: #selector(closeFilter), for: .touchUpInside)
//    }
//    
//    fileprivate func addSubviews() {
//        view.addSubview(titleLabel)
//        view.addSubview(closeButton)
//        view.addSubview(categoryTable.tableView)
//        view.addSubview(sourceTable.tableView)
//        view.addSubview(applyButton)
//    }
//    
//    fileprivate func addSubviewConstraints() {
//        addTitleLabelConstraints()
//        addCloseButtonConstraints()
//        addCategoryTableConstraints()
//        addSourceTableConstraints()
//        addApplyButtonConstraints()
//    }
//    
//    @objc fileprivate func applyFilter() {
////        var filter: Set<Int> = []
//        var sourceFilterString = ""
//        let sources = sourceTable.getSources()
//        for i in 0..<sources.count {
//            if let cell = sourceTable.tableView.cellForRow(at: [0, i]) as? CategoryCell {
//                if cell.optIn {
////                    filter.insert(i)
//                    if let sourceId = sources[i].id {
//                        sourceFilterString.append("&sources=\(sourceId)")
//                    }
//                }
//            }
//        }
//        print(sourceFilterString)
//        sourcesFilterDelegate?.passSourcesFilter(filterWith: sourceFilterString)
//        dismiss(animated: true)
//    }
//    
//    @objc fileprivate func closeFilter() {
//        dismiss(animated: true)
//    }
//    
//    fileprivate func addTitleLabelConstraints() {
//        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
//        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//    
//    fileprivate func addCloseButtonConstraints() {
//        closeButton.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
//        closeButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
//        closeButton.widthAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
//        closeButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
//        
//        closeButton.imageView?.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor).isActive = true
//        closeButton.imageView?.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
//        closeButton.imageView?.widthAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 0.65).isActive = true
//        closeButton.imageView?.heightAnchor.constraint(equalTo: closeButton.heightAnchor, multiplier: 0.65).isActive = true
//    }
//    
//    fileprivate func addCategoryTableConstraints() {
//        categoryTable.tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18).isActive = true
//        categoryTable.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        categoryTable.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//        categoryTable.tableView.bottomAnchor.constraint(equalTo: applyButton.topAnchor, constant: -12).isActive = true
//    }
//    
//    fileprivate func addSourceTableConstraints() {
//        sourceTable.tableView.topAnchor.constraint(equalTo: categoryTable.tableView.topAnchor).isActive = true
//        sourceTable.tableView.leadingAnchor.constraint(equalTo: categoryTable.tableView.leadingAnchor).isActive = true
//        sourceTable.tableView.trailingAnchor.constraint(equalTo: categoryTable.tableView.trailingAnchor).isActive = true
//        sourceTable.tableView.bottomAnchor.constraint(equalTo: categoryTable.tableView.bottomAnchor).isActive = true
//    }
//    
//    fileprivate func addApplyButtonConstraints() {
//        applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
//        applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
//        applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
//        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//}
//
//private typealias SelectedCategory = SearchPageFilter
//extension SelectedCategory: PassingSelectedCategory {
//    func passCategory(category: String) {
////        let categoriesLocalisationMap = [
////            String(localized: "business"): "Business",
////            String(localized: "entertainment"): "Entertainment",
////            String(localized: "general"): "General",
////            String(localized: "health"): "Health",
////            String(localized: "science"): "Science",
////            String(localized: "sports"): "Sports",
////            String(localized: "technology"): "Technology"
////        ]
//        
//        if let selectedCategory = UtilityClass.categoriesLocalisationMap[category] {
//            fetchSources(forCategory: selectedCategory)
//        }
//        titleLabel.text = String(localized: "select_sources")
//        categoryTable.tableView.isHidden = true
//        sourceTable.tableView.isHidden = false
//        applyButton.isHidden = false
//    }
//    
//    func fetchSources(forCategory category: String) {
//        Networking.sharedInstance.getSources(forCategory: category) {[weak self] result in
//            switch result {
//            case .success(let sources):
//                guard let fetchedSources = sources.sources else {
//                    return
//                }
//                self?.sourceTable.setSources(to: fetchedSources)
//                print(sources)
//            case.failure(let error):
//                switch error {
//                default:
//                    print(error)
//                }
//            }
//        }
//    }
//}
//
//protocol PassingSelectedCategory {
//    func passCategory(category: String)
//}
//
//final class ModifiedCategoryTableView: CategoryListTableViewController {
//    var categoryDelegate: PassingSelectedCategory?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryCell else {
//            return
//        }
//        if let categoryName = cell.categoryName.text {
//            print(categoryName)
//            categoryDelegate?.passCategory(category: categoryName)
//        }
//    }
//}
