//
//  SearchCell.swift
//  diary
//
//  Created by 김부성 on 2021/11/06.
//

import Foundation

import ReactorKit
import ActiveLabel
import Atributika
import UIKit

final class SearchCell: BaseTableViewCell, View {
    
    typealias Reactor = SearchReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        // DateView
        static let dateViewTop = 15.f
        static let dateViewSize = 30.f
        
        // Cell
        static let cellSide = 32.f
        
        // Content Label
        static let contentTop = 15.f
        
        // hashtag Label
        static let hashtagTop = 15.f
        
        // Separator Label
        static let separatorTop = 20.f
        static let separatorHeight = 1.f
        
    }
    
    fileprivate struct Font {
        // Date Label
        static let dateFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        // Tag Label
        static let tagLabelFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        // Content Label
        static let contentFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        static let lineStyle = NSMutableParagraphStyle().then {
            $0.lineSpacing = 10
            $0.lineBreakMode = .byTruncatingTail
        }
    }
    
    fileprivate struct LabelActive {
        static let customType = ActiveType.custom(pattern: "#[\\p{L}0-9_-]*")
    }
    
    // MARK: - UI
    let dateView = UIView().then {
        $0.theme.backgroundColor = themeService.attribute { $0.mainColor }
        $0.layer.cornerRadius = Metric.dateViewSize / 2
        $0.clipsToBounds = true
    }
    
    let dateLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = Font.dateFont
        $0.text = "24"
    }
    
    let contentLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.font = Font.contentFont
    }
    
    let hashtagLabel = ActiveLabel().then {
        $0.enabledTypes = [LabelActive.customType]
        $0.theme.customColor = themeService.attribute { $0.thirdColor }
        $0.font = Font.tagLabelFont
        $0.adjustsFontForContentSizeCategory = true
    }
    
    let separatorView = UIView().then {
        $0.backgroundColor = R.color.tableViewCellColor()
    }
    
    // MARK: - Initializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        
//        hashtagLabel.handleCustomTap(for: LabelActive.customType) { [weak self] element in
//            
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.dateView)
        self.dateView.addSubview(self.dateLabel)
        self.addSubview(self.contentLabel)
        self.addSubview(self.hashtagLabel)
        self.addSubview(self.separatorView)
        
        self.dateView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Metric.dateViewTop)
            $0.left.equalToSuperview().offset(Metric.cellSide)
            $0.width.height.equalTo(Metric.dateViewSize)
        }
        
        self.dateLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentLabel.snp.makeConstraints {
            $0.top.equalTo(self.dateView.snp.bottom).offset(Metric.contentTop)
            $0.leading.equalToSuperview().offset(Metric.cellSide)
            $0.trailing.equalToSuperview().offset(-Metric.cellSide)
        }
        
        self.hashtagLabel.snp.makeConstraints {
            $0.top.equalTo(self.contentLabel.snp.bottom).offset(Metric.hashtagTop)
            $0.leading.equalToSuperview().offset(Metric.cellSide)
            $0.trailing.equalToSuperview().offset(-Metric.cellSide)
        }
        
        self.separatorView.snp.makeConstraints {
            $0.top.equalTo(self.hashtagLabel.snp.bottom).offset(Metric.separatorTop)
            $0.left.equalToSuperview().offset(Metric.cellSide)
            $0.right.equalToSuperview().offset(-Metric.cellSide)
            $0.height.equalTo(Metric.separatorHeight)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: SearchReactor) {
        reactor.state.map { $0.date.days }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.dateLabel.rx.animated.fade(duration: 0.2).text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.content.styleAll(.paragraphStyle(Font.lineStyle)).attributedString }.asObservable()
            .bind(to: self.contentLabel.rx.animated.fade(duration: 0.2).attributedText)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.tags }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.hashtagLabel.rx.animated.fade(duration: 0.2).text)
            .disposed(by: disposeBag)
    }
    
}
