//
//  DiaryButton.swift
//  diary
//
//  Created by 김부성 on 2021/08/27.
//

import UIKit

final class DiaryButton: UIButton {
    
    fileprivate struct Font {
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 7
        self.backgroundColor = R.color.mainColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(self.isHighlighted ? 0.3 : 0.7)
            }
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = self.isEnabled ? R.color.mainColor() : R.color.diaryButtonDisabled()
            }
        }
    }
    
}
