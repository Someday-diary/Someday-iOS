//
//  SearchSectionHeaderView.swift
//  diary
//
//  Created by 김부성 on 2021/11/07.
//

import UIKit

class SearchSectionHeaderView: UITableViewHeaderFooterView {
    
    fileprivate struct Metric {
        static let cellSide = 32.f
    }
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    // MARK: - UI
    var background = UIView().then {
        $0.backgroundColor = R.color.diaryBackgroundColor()
    }
    
    var titleLabel = UILabel().then {
        $0.font = Font.titleFont
    }
    
    
    // MARK: - init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.addSubview(self.background)
        self.background.addSubview(self.titleLabel)
        
        self.background.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.cellSide)
            $0.centerY.equalToSuperview()
        }
        
    }
}
