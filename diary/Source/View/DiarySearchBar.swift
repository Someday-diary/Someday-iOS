//
//  DiarySearchBar.swift
//  diary
//
//  Created by 김부성 on 2021/10/03.
//

import UIKit

final class DiarySearchBar: UISearchBar {
    
    // MARK: - Constants
    fileprivate struct Style {
        static let cornerRadius = 5.f
        static let borderWidth = 1.f
    }
    
    fileprivate struct Metric {
        static let buttonWidth = 30.f
        static let imageWidth = 16.f
    }
    
    fileprivate struct Font {
        
    }
    
    // MARK: - UI
    let leftButton = UIButton(type: .system).then {
        $0.setImage(R.image.arrowIcon(), for: .normal)
        $0.theme.tintColor = themed { $0.mainColor }
    }
    
    let leftView = UIView().then {
        $0.alpha = 0
    }
    
    // MARK: - Inititalizing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.searchTextField.leftView = self.leftView
        self.searchTextField.backgroundColor = .clear
        self.searchTextField.layer.cornerRadius = Style.cornerRadius
        self.searchTextField.layer.borderWidth = Style.borderWidth
        self.searchTextField.layer.theme.borderColor = themed { $0.mainColor.cgColor }
        self.searchTextField.theme.clearButtonTintColor = themed { $0.clearButtonColor }
        self.theme.tintColor = themed { $0.mainColor }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.leftView.addSubview(self.leftButton)
        
        self.leftView.snp.makeConstraints {
            $0.width.equalTo(Metric.buttonWidth)
        }
        
        self.leftButton.snp.makeConstraints {
            $0.width.equalTo(Metric.imageWidth)
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    
}

