//
//  DiarySideMenuListButton.swift
//  diary
//
//  Created by 김부성 on 2021/09/02.
//

import UIKit
import RxSwift
import RxCocoa

class DiarySideMenuListButton: UIView {

    // MARK: - Constants
    fileprivate struct Metric {
        // Image
        static let imageWidth = 29.f
        static let imageHeight = 27.f
        
        // ImageBackGround
        static let backgroundCornerRadius = 11.f
        static let backgroundTop = 5.f
        static let backgroundLeft = 7.f
        
        // Icon
        static let iconBottom = 3.f
        
        // Button
        static let buttonLeft = 20.f
        
        // Height
        static let height = 35.f
    }
    
    fileprivate struct Font {
        static let buttonFont = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    
    // MARK: - UI
    let imageArea = UIView()
    
    let icon = UIImageView().then {
        $0.theme.tintColor = themed { $0.mainColor }
    }
    
    let imageBackground = UIView().then {
        $0.theme.backgroundColor = themed { $0.subColor }
        $0.layer.cornerRadius = Metric.backgroundCornerRadius
    }
    
    let button = UIButton().then {
        $0.contentHorizontalAlignment = .left
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = Font.buttonFont
        $0.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - Inititalizing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        self.addSubview(imageArea)
        self.imageArea.addSubview(imageBackground)
        self.imageArea.addSubview(icon)
        self.addSubview(button)
        
        self.imageArea.snp.makeConstraints {
            $0.centerY.left.equalToSuperview()
            $0.height.equalTo(Metric.imageHeight)
            $0.width.equalTo(Metric.imageWidth)
        }
        
        self.icon.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Metric.iconBottom)
        }
        
        self.imageBackground.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.backgroundLeft)
            $0.right.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(Metric.backgroundTop)
        }
        
        self.button.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.left.equalTo(self.imageArea.snp.right).offset(Metric.buttonLeft)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(Metric.height)
        }
    }
    
}
