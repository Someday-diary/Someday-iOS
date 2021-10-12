//
//  ThemeViewSection.swift.swift
//  diary
//
//  Created by 김부성 on 2021/10/10.
//

import RxDataSources

enum ThemeViewSection {
    case appearance([ThemeViewSectionItem])
}

extension ThemeViewSection: SectionModelType {
    typealias Item = ThemeViewSectionItem
    
    var items: [ThemeViewSectionItem] {
        switch self {
        case let .appearance(items):
            return items
        }
    }
    
    init(original: ThemeViewSection, items: [ThemeViewSectionItem]) {
        switch original {
        case let .appearance(items):
            self = .appearance(items)
        }
    }
}

enum ThemeViewSectionItem {
    case appearance(AppearanceReactor)
}
