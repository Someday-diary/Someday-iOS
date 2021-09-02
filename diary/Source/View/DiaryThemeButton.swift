//
//  DiaryThemeButton.swift
//  diary
//
//  Created by 김부성 on 2021/08/31.
//

import UIKit

class DiaryThemeButton: UIButton {
    
    
    // MARK: - Constants
    fileprivate struct Style {
        
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
        self.layer.cornerRadius = self.bounds.size.width / 2
    }
    
    override public var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(self.isHighlighted ? 0.5 : 1)
            }
        }
    }
    
}
