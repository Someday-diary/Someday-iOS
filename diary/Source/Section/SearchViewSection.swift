//
//  SearchViewSection.swift
//  diary
//
//  Created by 김부성 on 2021/11/07.
//

import RxDataSources

enum SearchViewSection {
    case diary([SearchViewSectionItem])
}

extension SearchViewSection: SectionModelType {
    typealias Item = SearchViewSectionItem
    
    var items: [SearchViewSectionItem] {
        switch self {
        case let .diary(items):
            return items
        }
    }
    
    init(original: SearchViewSection, items: [SearchViewSectionItem]) {
        switch original {
        case let .diary(items):
            self = .diary(items)
        }
    }
}

enum SearchViewSectionItem {
    case diary(SearchReactor)
}
