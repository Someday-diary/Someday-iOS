//
//  ThemeSectionHeaderView.swift
//  diary
//
//  Created by 김부성 on 2021/10/13.
//

import UIKit

class ThemeSectionHeaderView: UITableViewHeaderFooterView {
    
    fileprivate struct Metric {
        static let cellSide = 32.f
    }
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    // MARK: - UI
    var title = UILabel().then {
        $0.font = Font.titleFont
        $0.theme.textColor = themed { $0.tableViewCellColor }
        $0.text = "section"
    }
    
    var background = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.addSubview(self.background)
        self.background.addSubview(self.title)
        
        self.background.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(Metric.cellSide)
        }
        
    }
}
