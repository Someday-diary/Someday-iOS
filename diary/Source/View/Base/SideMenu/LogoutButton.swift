//
//  LogoutButton.swift
//  diary
//
//  Created by 김부성 on 2021/09/03.
//

import UIKit

class LogoutButton: UIButton {
    
    // MARK: - Constants
    fileprivate struct Style {
        // LogoutIcon
        static let logoutSize = 26.f
        static let logoutLeft = 8.f
        
        // Label
        static let labelRight = 15.f
        static let labelLeft = 8.f
        
        // Button
        static let cornerRadius = 10.f
        static let height = 50.f
    }
    
    fileprivate struct Font {
        static let labelFont = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    // MARK: - UI
    let logoutIcon = UIImageView().then {
        $0.image = R.image.logoutIcon()
        $0.theme.tintColor = themed { $0.mainColor }
    }
    
    let label = UILabel().then {
        $0.text = "로그아웃"
        $0.textAlignment = .center
        $0.font = Font.labelFont
        $0.adjustsFontSizeToFitWidth = true
    }
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = Style.cornerRadius
        self.clipsToBounds = true
        
        self.addSubview(logoutIcon)
        self.addSubview(label)
        
        self.logoutIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(Style.logoutSize)
            $0.right.equalToSuperview().offset(-Style.logoutLeft)
        }
        
        self.label.snp.makeConstraints {
            $0.right.equalTo(self.logoutIcon.snp.left).offset(-Style.labelRight)
            $0.left.equalToSuperview().offset(Style.labelLeft)
            $0.centerY.equalToSuperview()
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
