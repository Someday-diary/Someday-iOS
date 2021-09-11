//
//  MainCell.swift
//  diary
//
//  Created by 김부성 on 2021/09/10.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

final class MainCell: BaseTableViewCell, View {
    
    typealias Reactor = MainCellReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        
    }
    
    fileprivate struct Font {
        
    }
    
    
    // MARK: - Properties
    
    // MARK: - UI
    
    // MARK: - Inintializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    // MARK: - Configuring
    func bind(reactor: MainCellReactor) {
        
    }

}
