//
//  SendCodeButton.swift
//  diary
//
//  Created by 김부성 on 2021/12/01.
//

import UIKit

final class SendCodeButton: UIButton {
    
    // MARK: - Constants
    fileprivate struct Style {
        static let cornerRadius = 8.f
    }

    // MARK: - UI
    fileprivate struct Font {
        static let codeFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = Style.cornerRadius
        self.clipsToBounds = true
        self.titleLabel?.font = Font.codeFont
        self.theme.titleColor(from: themeService.attribute { $0.thirdColor }, for: .normal)
        self.theme.titleColor(from: themeService.attribute { $0.systemWhiteColor }, for: .disabled)
    }
    
    override public var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(self.isHighlighted ? 0.5 : 1)
            }
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                if self.isEnabled {
                    self.theme.backgroundColor = themeService.attribute { $0.subColor }
                } else {
                    self.theme.backgroundColor = themeService.attribute { $0.diaryDisableColor }
                }
            }
        }
    }
    
}

