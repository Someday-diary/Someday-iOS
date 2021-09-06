//
//  WriteDiaryButton.swift
//  diary
//
//  Created by 김부성 on 2021/09/06.
//

import UIKit

class WriteDiaryButton: UIButton {

    // MARK: - Constants
    fileprivate struct Style {
        // Icon
        static let iconSize = 10.f
        static let iconLeft = 5.f
        
        // Label
        static let labelLeft = 7.f
        
        // Button
        static let height = 35.f
        static let cornerRadius = 10.f
    }
    
    fileprivate struct Font {
        static let labelFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    // MARK: - UI
    let icon = UIImageView().then {
        $0.theme.tintColor = themed { $0.mainColor }
        $0.image = R.image.add()
    }
    
    let label = UILabel().then {
        $0.textAlignment = .left
        $0.font = Font.labelFont
        $0.adjustsFontSizeToFitWidth = true
        $0.text = "일기 추가하기"
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
        
        self.addSubview(icon)
        self.addSubview(label)
        
        
        self.icon.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Style.iconLeft)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(Style.iconSize)
        }
        
        self.label.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.left.equalTo(self.icon.snp.right).offset(Style.labelLeft)
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


