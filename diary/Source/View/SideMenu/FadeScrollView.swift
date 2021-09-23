//
//  FadeScrollView.swift
//  diary
//
//  Created by 김부성 on 2021/09/23.
//

import UIKit

final class FadeScrollView: UIScrollView {
    
    // MARK: - Constants
    fileprivate struct Style {
        
    }
    
    fileprivate struct Font {
        
    }
    
    // MARK: - UI
    let gradient = CAGradientLayer().then {
        $0.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        $0.locations = [0, 0.1, 0.9, 1]
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
        
        gradient.frame = self.bounds
        self.layer.mask = gradient
    }
    
}
