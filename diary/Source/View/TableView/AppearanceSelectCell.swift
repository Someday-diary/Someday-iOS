//
//  AppearanceSelectCell.swift
//  diary
//
//  Created by 김부성 on 2021/10/07.
//

import UIKit

import ReactorKit

final class AppearanceSelectCell: BaseTableViewCell, View {
    
    typealias Reactor = AppearanceSelectReactor
    
    // MARK: Constants
    fileprivate struct Metric {
        static let imageWidth = 44.f
        static let iamgeHeight = 70.f
        
        static let titleLeft = 16.f
        
        static let buttonSize = 16.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 14, weight: .bold)
    }

    // MARK: - UI
    let image = UIImageView().then {
        $0.image = R.image.systemMode()
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 2
        $0.layer.theme.borderColor = themed { $0.thirdColor.cgColor }
    }
    
    let title = UILabel().then {
        $0.text = "시스템 설정모드"
        $0.theme.textColor = themed { $0.thirdColor }
        $0.font = Font.titleFont
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let button = UIButton().then {
        $0.setImage(R.image.selectedButton(), for: .selected)
        $0.setImage(R.image.unSelectedButton(), for: .normal)
        $0.theme.tintColor = themed { $0.thirdColor }
    }
    
    // MARK: - Initializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        
        self.addSubview(self.image)
        self.addSubview(self.title)
        self.addSubview(self.button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.image.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.height.equalTo(Metric.iamgeHeight)
            $0.width.equalTo(Metric.imageWidth)
        }
        
        self.title.snp.makeConstraints {
            $0.left.equalTo(self.image.snp.right).offset(Metric.titleLeft)
            $0.right.equalTo(self.button.snp.left)
            $0.centerY.equalToSuperview()
        }
        
        self.button.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.width.height.equalTo(Metric.buttonSize)
            $0.centerY.equalToSuperview()
        }
    }

    // MARK: - Configuring
    
    func bind(reactor: AppearanceSelectReactor) {
        
    }
}
