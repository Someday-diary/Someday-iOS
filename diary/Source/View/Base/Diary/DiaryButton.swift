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
        static let borderWidth = 1.f
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
        super.layoutSubviews()
        
        self.layer.cornerRadius = Style.cornerRadius
        self.clipsToBounds = true
        self.layer.borderWidth = Style.borderWidth
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(R.color.diaryDisabledColor(), for: .disabled)
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
                if self.isEnabled {
                    self.theme.backgroundColor = themed { $0.mainColor }
                    self.layer.theme.borderColor = themed { $0.mainColor.cgColor }
                } else {
                    self.theme.backgroundColor = themed { $0.clearColor }
                    self.layer.theme.borderColor = themed { $0.diaryDisableColor.cgColor }
                }
            }
        }
    }
    
}
