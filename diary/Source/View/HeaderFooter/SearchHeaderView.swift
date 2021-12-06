//
//  SearchSectionHeaderView.swift
//  diary
//
//  Created by 김부성 on 2021/11/05.
//

import UIKit

class SearchHeaderView: UIView {
    
    fileprivate struct Metric {
        
    }
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 34, weight: .bold)
    }
    
    // MARK: - UI
    var title = UILabel().then {
        $0.font = Font.titleFont
        $0.theme.textColor = themed { $0.thirdColor }
        $0.text = "#"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = R.color.diaryBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.addSubview(self.title)
        
        self.title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
}
