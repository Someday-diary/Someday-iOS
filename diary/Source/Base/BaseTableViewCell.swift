//
//  BaseTableViewCell.swift
//  diary
//
//  Created by 김부성 on 2021/09/10.
//

import UIKit

import RxSwift

class BaseTableViewCell: UITableViewCell {
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    // MARK: - Initializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    // MARK: Sub init
    required convenience init?(coder: NSCoder) {
        self.init(style: .default, reuseIdentifier: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .clear
    }
}
