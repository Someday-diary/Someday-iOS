//
//  DiaryButton.swift
//  diary
//
//  Created by 김부성 on 2021/08/27.
//

import UIKit

final class DiaryButton: UIButton {
    
    // MARK: - Constants
    fileprivate struct Style {
        static let cornerRadius = 7.f
    }

    // MARK: - UI
    
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        self.layer.cornerRadius = Style.cornerRadius
        self.theme.backgroundColor = themed { $0.mainColor }
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
            UIView.animate(withDuration: 0.3) {
                self.theme.backgroundColor = self.isEnabled ? themed { $0.mainColor } : themed { $0.buttonDisableColor }
            }
        }
    }
    
}
