//
//  DiarySearchBar.swift
//  diary
//
//  Created by 김부성 on 2021/10/03.
//

import UIKit

final class DiarySearchBar: UIView {
    
    // MARK: - Constants
    fileprivate struct Style {
        static let cornerRadius = 5.f
        static let borderWidth = 1.f
    }
    
    fileprivate struct Metric {
        static let imageWidth = 16.f
        static let imageLeft = 16.f
        
        static let textFieldRight = 5.f
        static let textFieldLeft = 8.f
    }
    
    fileprivate struct Font {
        
    }
    
    // MARK: - UI
    let leftImage = UIImageView().then {
        $0.image = R.image.arrowIcon()
        $0.theme.tintColor = themed { $0.mainColor }
    }
    
    let textField = UITextField().then {
        $0.theme.tintColor = themed { $0.mainColor }
        $0.clearButtonMode = .whileEditing
    }
    
    // MARK: - Inititalizing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = Style.cornerRadius
        self.layer.borderWidth = Style.borderWidth
        self.layer.theme.borderColor = themed { $0.mainColor.cgColor }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.leftImage)
        self.addSubview(self.textField)
        
        self.leftImage.snp.makeConstraints {
            $0.width.equalTo(Metric.imageWidth)
            $0.left.equalToSuperview().offset(Metric.imageLeft)
            $0.centerY.equalToSuperview()
        }
        
        self.textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview().offset(-Metric.textFieldRight)
            $0.left.equalTo(self.leftImage.snp.right).offset(Metric.textFieldLeft)
        }
    }
    
}
