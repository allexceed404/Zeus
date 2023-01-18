//
//  FilterViewModel.swift
//  Zeus
//
//  Created by Priyanshu Verma on 16/01/23.
//

import Foundation
import UIKit

protocol FilterViewDelegate {
    func changeTitle(to titleText: String)
    func getTableView() -> UITableView
    func reloadFilterView()
    func isCellSelected(at index: Int) -> Bool
}

final class FilterViewModel {
    private var filterViewDelegate: FilterViewDelegate?
    private var webEventsDelegate: WebEventsDelegate?
    private var filterType: UtilityClass.FilterType = .category
    private var currentTableType: UtilityClass.FilterType = .category
    private var sourcesList: [SourceInfo] = [] {
        didSet {
            webEventsDelegate?.show(tableView: filterViewDelegate?.getTableView(), showTable: true, loading: false, noResults: false, noInternet: false)
            filterViewDelegate?.reloadFilterView()
        }
    }
    private var selectedFilters: [UtilityClass.FilterType: Set<String>] = [:]
    
    func assignFilterViewDelegate(as delegate: FilterViewDelegate) {
        filterViewDelegate = delegate
    }
    
    func assignWebEventsDelegate(as delegate: WebEventsDelegate) {
        webEventsDelegate = delegate
    }
    
    func getFilterType() -> UtilityClass.FilterType {
        return filterType
    }
    
    func setFilterType(to filter: UtilityClass.FilterType) {
        filterType = filter
    }
    
    func getCurrentTableType() -> UtilityClass.FilterType {
        return currentTableType
    }
    
    func setSelectedFilters(filterType: UtilityClass.FilterType, filter: Set<String>) {
        selectedFilters[filterType] = filter
    }
    
    func numberOfRows() -> Int {
        if currentTableType == .category {
            print(UtilityClass.Category.allCases.count)
            return UtilityClass.Category.allCases.count
        } else {
            return sourcesList.count
        }
    }
    
    func getInfoForCellAt(index: Int) -> String? {
        if currentTableType == .category {
            if index<UtilityClass.Category.allCases.count {
                return UtilityClass.Category.allCases[index].rawValue
            } else {
                return nil
            }
        } else {
            if index<sourcesList.count {
                if let sourceName = sourcesList[index].name {
                    return sourceName
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
    }
    
    func isFilterPresent(in type: UtilityClass.FilterType, item: String) -> Bool {
        guard let typeList = selectedFilters[type] else {
            return false
        }
        return typeList.contains(item)
    }
    
    func selectionHandler(for index: Int) {
        if currentTableType != filterType {
            currentTableType = .source
            filterViewDelegate?.changeTitle(to: String(localized: "select_sources"))
            webEventsDelegate?.show(tableView: filterViewDelegate?.getTableView(), showTable: false, loading: true, noResults: false, noInternet: false)
            Networking.sharedInstance.getSourceList(forCategory: UtilityClass.Category.allCases[index].rawValue){[weak self] result in
                switch result {
                case .success(let sources):
                    print(sources)
                    guard let sourceList = sources.sources else {
                        return
                    }
                    self?.sourcesList = sourceList
                case .failure(let error):
                    switch error {
                    case .NoDataAvailable:
                        self?.webEventsDelegate?.show(tableView: self?.filterViewDelegate?.getTableView(), showTable: false, loading: false, noResults: true, noInternet: false)
                    case .NoInternetConnection:
                        self?.webEventsDelegate?.show(tableView: self?.filterViewDelegate?.getTableView(), showTable: false, loading: false, noResults: false, noInternet: true)
                    default:
                        print(error)
                    }
                }
            }
        }
    }
    
    func getFilter() -> [String] {
        print(#function)
        var filterList: [String] = []
        if filterType == .category {
            for index in 0..<UtilityClass.Category.allCases.count {
                guard let isSelected = filterViewDelegate?.isCellSelected(at: index) else {
                    continue
                }
                if isSelected {
                    filterList.append(UtilityClass.Category.allCases[index].rawValue)
                }
            }
        } else {
            for index in 0..<sourcesList.count {
                guard let isSelected = filterViewDelegate?.isCellSelected(at: index) else {
                    continue
                }
                guard let sourceId = sourcesList[index].id else {
                    continue
                }
                if isSelected {
                    filterList.append(sourceId)
                }
            }
        }
        return filterList
    }
}
