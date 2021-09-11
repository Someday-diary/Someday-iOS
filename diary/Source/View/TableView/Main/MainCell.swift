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
        // MainCell
        static let side = 30.f
        // DateView
        static let dateViewSize = 30.f
    }
    
    fileprivate struct Style {
        // HeaderView
    }
    
    fileprivate struct Font {
        // Date Label
        static let dateFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        // Edit Button
        static let buttonFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    
    // MARK: - Properties
    
    // MARK: - UI
    let headerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let dateView = UIView().then {
        $0.theme.backgroundColor = themed { $0.mainColor }
        $0.layer.cornerRadius = Metric.dateViewSize / 2
        $0.clipsToBounds = true
    }
    
    let dateLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = Font.dateFont
        $0.text = "24"
    }
    
    let editButton = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = Font.buttonFont
    }
    
    let textView = UITextView().then {
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
    }
    
    
    // MARK: - Inintializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.theme.backgroundColor = themed { $0.subColor }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.headerView)
        self.addSubview(self.textView)
        self.headerView.addSubview(self.dateView)
        self.headerView.addSubview(self.editButton)
        self.dateView.addSubview(self.dateLabel)
        
        self.headerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.side)
            $0.right.equalToSuperview().offset(-Metric.side)
            $0.height.equalTo(self.snp.height).dividedBy(2)
            $0.top.equalToSuperview()
        }
        
        self.textView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.side)
            $0.right.equalToSuperview().offset(-Metric.side)
            $0.height.equalTo(self.snp.height).dividedBy(2)
            $0.bottom.equalToSuperview()
        }
        
        self.dateView.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.width.height.equalTo(Metric.dateViewSize)
        }
        
        self.dateLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.editButton.snp.makeConstraints {
            $0.right.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: MainCellReactor) {
        
    }

}
