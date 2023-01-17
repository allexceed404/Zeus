//
//  FilterEvents.swift
//  Zeus
//
//  Created by Priyanshu Verma on 16/01/23.
//

import UIKit

protocol FilterEventsDelegate {
    func closeFilterPage()
    func applyFilter(as filter: [String])
}

protocol FilterEvents {
    var newsView: NewsViewController {get}
    var filterButton: GenericButton {get}
    
    func goToFilter(filterEventsDelegate: FilterEventsDelegate, filterType: UtilityClass.FilterType, filter: [String])
    func closeFilterPage()
}

extension FilterEvents where Self: UIViewController {
    func goToFilter(filterEventsDelegate: FilterEventsDelegate, filterType: UtilityClass.FilterType, filter: [String]) {
        let filterPage = FilterViewController()
        filterPage.assignFilterEventsDelegate(as: filterEventsDelegate)
        filterPage.setFilterType(to: filterType)
        var filterList: Set<String> = []
        for filterItem in filter {
            filterList.insert(filterItem)
        }
        filterPage.setSelectedFilters(filterType: filterType, filter: filterList)
        self.navigationController?.pushViewController(filterPage, animated: true)
    }
    func closeFilterPage() {
        self.navigationController?.popViewController(animated: true)
    }
}
