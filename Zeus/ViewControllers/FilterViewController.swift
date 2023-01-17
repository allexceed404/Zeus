//
//  FilterViewController.swift
//  Zeus
//
//  Created by Priyanshu Verma on 16/01/23.
//

import UIKit

final class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WebEvents, WebEventsDelegate {
    private var filterEventsDelegate: FilterEventsDelegate?
    private let titleLabel: GenericLabel = {
        let label = GenericLabel(frame: .zero, text: String(localized: "select_a_category"), textColor: .label, textSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    private let closeButton: GenericButton = {
        let button = GenericButton(frame: .zero, systemImage: "xmark.circle", tintColor: .black, backgroundColor: .systemYellow)
        return button
    }()
    
    private let tableView = UITableView()
    private let viewModel = FilterViewModel()
    
    internal var loadingScreen = LoadingScreen()
    internal var noResultsScreen = NoResultsFound()
    internal var noInternetScreen = NoInternetConnection()
    
    private let applyFilterButton: GenericButton = {
        let button = GenericButton(frame: .zero, systemImage: "tick", tintColor: .black, backgroundColor: .systemYellow, text: String(localized: "apply_filter"))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.assignFilterViewDelegate(as: self)
        viewModel.assignWebEventsDelegate(as: self)
        
        view.addSubview(titleLabel)
        
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        
        view.addSubview(tableView)
        setupTableView()
        
        view.addSubview(applyFilterButton)
        if(viewModel.getCurrentTableType() != viewModel.getFilterType()) {
            applyFilterButton.isHidden = true
        }
        applyFilterButton.addTarget(self, action: #selector(applyFilterButtonAction), for: .touchUpInside)
        
        addSubviewContraints()
        
        setScreenConstraints(superView: view, tableView: tableView, view: loadingScreen.view)
        setScreenConstraints(superView: view, tableView: tableView, view: noResultsScreen.view)
        setScreenConstraints(superView: view, tableView: tableView, view: noInternetScreen.view)
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(FilterCell.self, forCellReuseIdentifier: "FilterCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for index in 0..<viewModel.numberOfRows() {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: [0, index]) as? FilterCell else {
                return
            }
            let cellTitle = viewModel.getInfoForCellAt(index: index)
            if let cellTitle {
                if viewModel.isFilterPresent(in: viewModel.getCurrentTableType(), item: cellTitle) {
                    cell.setSelected(true, animated: true)
                }
            }
        }
    }

    func assignFilterEventsDelegate(as delegate: FilterEventsDelegate) {
        filterEventsDelegate = delegate
    }
    
    func setFilterType(to filter: UtilityClass.FilterType) {
        viewModel.setFilterType(to: filter)
    }
    
    func setSelectedFilters(filterType: UtilityClass.FilterType, filter: Set<String>) {
        viewModel.setSelectedFilters(filterType: filterType, filter: filter)
    }
    
    @objc func closeButtonAction() {
        filterEventsDelegate?.closeFilterPage()
    }
    
    @objc func applyFilterButtonAction() {
        print(#function)
        let filter = viewModel.getFilter()
        print(filter)
        filterEventsDelegate?.applyFilter(as: filter)
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterCell else {
            return UITableViewCell()
        }
        let cellTitle = viewModel.getInfoForCellAt(index: indexPath.row)
        if let cellTitle {
            cell.setCellName(to: cellTitle)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectionHandler(for: indexPath.row)
    }
}

private typealias FilterViewDelegateConformance = FilterViewController
extension FilterViewDelegateConformance: FilterViewDelegate {
    func changeTitle(to titleText: String) {
        titleLabel.text = titleText
    }
    
    func getTableView() -> UITableView {
        return tableView
    }
    
    func reloadFilterView() {
        DispatchQueue.main.async {
            print(self.viewModel.numberOfRows())
            self.tableView.reloadData()
            if(self.viewModel.getCurrentTableType() == self.viewModel.getFilterType()) {
                self.applyFilterButton.isHidden = false
            }
        }
    }
    
    func isCellSelected(at index: Int) -> Bool {
        guard let cell = tableView.cellForRow(at: [0, index]) as? FilterCell else {
            return false
        }
        return cell.isSelected
    }
}

private typealias AddSubviewConstraints = FilterViewController
extension AddSubviewConstraints {
    fileprivate func addSubviewContraints() {
        addTitleLabelConstraints()
        addCloseButtonConstraints()
        addTableViewConstraints()
        addApplyFilterButtonConstraints()
    }
    
    fileprivate func addTitleLabelConstraints() {
        titleLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.height).isActive = true
    }
    
    fileprivate func addCloseButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    fileprivate func addTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 18).isActive = true
        tableView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 18).isActive = true
        tableView.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: -18).isActive = true
        tableView.bottomAnchor.constraint(equalTo: applyFilterButton.topAnchor, constant: -12).isActive = true
    }
    
    fileprivate func addApplyFilterButtonConstraints() {
        applyFilterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
        applyFilterButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        applyFilterButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        applyFilterButton.heightAnchor.constraint(equalToConstant: (applyFilterButton.intrinsicContentSize.height*1.5)).isActive = true
    }
}
