//
//  DiarySideMenuListButton.swift
//  diary
//
//  Created by 김부성 on 2021/09/02.
//

import UIKit
import RxSwift
import RxCocoa

class DiarySideMenuListButton: UIView {

    // MARK: - Constants
    fileprivate struct Metric {
        static let imageWidth = 29.f
        static let imageHeight = 27.f
    }
    
    // MARK: - UI
    let imageArea = UIView()
    
    let icon = UIImageView().then {
        $0.theme.tintColor = themed { $0.mainColor }
    }
    
    let imageBackground = UIView().then {
        $0.theme.backgroundColor = themed { $0.subColor }
        $0.layer.cornerRadius = 11
    }
    
    let button = UIButton().then {
        $0.contentHorizontalAlignment = .left
        $0.setTitleColor(.black, for: .normal)
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
        self.addSubview(imageArea)
        self.imageArea.addSubview(imageBackground)
        self.imageArea.addSubview(icon)
        self.addSubview(button)
        
        self.imageArea.snp.makeConstraints {
            $0.centerY.left.equalToSuperview()
            $0.height.equalTo(Metric.imageHeight)
            $0.width.equalTo(Metric.imageWidth)
        }
        
        self.icon.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-3)
        }
        
        self.imageBackground.snp.makeConstraints {
            $0.left.equalToSuperview().offset(7)
            $0.right.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
        }
        
        self.button.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.left.equalTo(self.imageArea.snp.right).offset(20)
        }
    }
    
}
