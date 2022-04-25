//
//  DiarySideMenuListButton.swift
//  diary
//
//  Created by 김부성 on 2021/09/03.
//

import UIKit

class DiarySideMenuListButton: UIButton {

    // MARK: - Constants
    fileprivate struct Style {
        // Image
        static let imageWidth = 29.f
        static let imageHeight = 27.f
        static let imageLeft = 8.f
        
        // ImageBackGround
        static let backgroundCornerRadius = 11.f
        static let backgroundTop = 5.f
        static let backgroundLeft = 7.f
        
        // Icon
        static let iconBottom = 3.f
        static let iconRight = 5.f
        
        // Label
        static let labelLeft = 20.f
        
        // Button
        static let height = 50.f
        static let cornerRadius = 10.f
    }
    
    fileprivate struct Font {
        static let labelFont = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    // MARK: - UI
    let imageArea = UIView()
    
    let icon = UIImageView().then {
        $0.theme.tintColor = themeService.attribute { $0.mainColor }
    }
    
    let imageBackground = UIView().then {
        $0.theme.backgroundColor = themeService.attribute { $0.subColor }
        $0.layer.cornerRadius = Style.backgroundCornerRadius
    }
    
    let label = UILabel().then {
        $0.textAlignment = .left
        $0.font = Font.labelFont
        $0.adjustsFontSizeToFitWidth = true
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
        super.layoutSubviews()
        
        self.layer.cornerRadius = Style.cornerRadius
        self.clipsToBounds = true
        
        self.addSubview(imageArea)
        self.imageArea.addSubview(imageBackground)
        self.imageArea.addSubview(icon)
        self.addSubview(label)
        
        self.imageArea.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(Style.imageLeft)
            $0.height.equalTo(Style.imageHeight)
            $0.width.equalTo(Style.imageWidth)
        }
        
        self.icon.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Style.iconBottom)
        }
        
        self.imageBackground.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Style.backgroundLeft)
            $0.right.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(Style.backgroundTop)
        }
        
        self.label.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.left.equalTo(self.imageArea.snp.right).offset(Style.labelLeft)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(Style.height)
        }
    }
    
    override public var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = UIColor.black.withAlphaComponent(self.isHighlighted ? 0.05 : 0)
            }
        }
    }
    
}

