//
//  SourcesView.swift
//  Zeus
//
//  Created by Priyanshu Verma on 09/01/23.
//

import UIKit

class SourcesView: TableViewController {
    private var sources: [SourceInfo] = [] {
        didSet {
            DispatchQueue.main.async {
                print(self.sources.count)
                self.tableView.reloadData()
            }
        }
    }
    
    var filter: Set<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "SourceCell")
        tableView.rowHeight = 35
        tableView.separatorStyle = .none
//        tableView.allowsSelection = false
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell") as? CategoryCell else {
            return UITableViewCell()
        }
        if let sourceName = sources[indexPath.row].name {
            cell.setName(name: sourceName)
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
    
    func setSources(to fetchedSources: [SourceInfo]) {
        sources = fetchedSources
    }
    
    func getSources() -> [SourceInfo] {
        return sources
    }
    
    func getSource(at index: Int) -> SourceInfo? {
        if index<sources.count {
            return sources[index]
        } else {
            return nil
        }
    }
}
