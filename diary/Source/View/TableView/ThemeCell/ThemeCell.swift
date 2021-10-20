//
//  AppearanceCell.swift
//  diary
//
//  Created by 김부성 on 2021/10/07.
//

import UIKit

import ReactorKit

final class ThemeCell: BaseTableViewCell, View {
    
    typealias Reactor = ThemeReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        
    }
    
    fileprivate struct Font {
        
    }
    
    fileprivate struct Style {
        
    }

    // MARK: - UI
    
    
    // MARK: - Initializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }

    // MARK: - Configuring
    
    func bind(reactor: ThemeReactor) {
        
    }
}
