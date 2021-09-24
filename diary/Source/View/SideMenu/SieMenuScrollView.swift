//
//  SideMenuScrollView.swift
//  diary
//
//  Created by 김부성 on 2021/09/23.
//

import UIKit

final class SideMenuScrollView: UIView {
    
    // MARK: - Constants
    fileprivate struct Metric {
        
    }
    
    fileprivate struct Font {
        
    }
    
    // MARK: - UI
    let scrollView = UIScrollView()
    
    let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let gradient = CAGradientLayer().then {
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
        
        // Gradient
        self.layer.mask = gradient
        gradient.frame = self.bounds
        
        // Scroll view
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        
        self.scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(1200)
        }
        
    }
    
}
