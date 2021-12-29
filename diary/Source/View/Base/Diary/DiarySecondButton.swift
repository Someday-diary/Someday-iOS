//
//  SendCodeButton.swift
//  diary
//
//  Created by 김부성 on 2021/12/01.
//

import UIKit

final class DiarySecondButton: UIButton {
    
    // MARK: - Constants
    fileprivate struct Style {
        static let defaultCornerRadius = 12.f
    }

    // MARK: - UI
    fileprivate struct Font {
        static let defaultFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
        
        self.layer.cornerRadius = Style.defaultCornerRadius
        self.clipsToBounds = true
        self.titleLabel?.font = Font.defaultFont
        self.theme.titleColor(from: themed { $0.thirdColor }, for: .normal)
        self.theme.titleColor(from: themed { $0.disable }, for: .disabled)
    }
    
    override public var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.05) {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(self.isHighlighted ? 0.5 : 1)
            }
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                if self.isEnabled {
                    self.theme.backgroundColor = themed { $0.subColor }
                } else {
                    self.theme.backgroundColor = themed { $0.background2 }
                }
            }
        }
    }
    
}

