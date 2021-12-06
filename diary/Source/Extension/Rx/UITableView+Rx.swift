//
//  UITableView+Rx.swift
//  diary
//
//  Created by 김부성 on 2021/10/12.
//

import RxSwift
import RxDataSources
import RxCocoa

extension Reactive where Base: UITableView {
    func itemSelected<S>(dataSource: TableViewSectionedDataSource<S>) -> ControlEvent<S.Item> {
        let source = self.itemSelected.map { indexPath in
            dataSource[indexPath]
        }
        return ControlEvent(events: source)
    }
}
