//
//  DiaryTextField.swift
//  diary
//
//  Created by 김부성 on 2021/08/24.
//

import UIKit
import RxSwift
import RxCocoa

final class DiaryTextField: UIView {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()

    // MARK: - Constants
    fileprivate struct Metric {
        // textField
        static let textFieldTop = 5.f
        static let textFieldSide = 11.f
        
        // separator
        static let separatorTop = 5.f
        static let separatorHeight = 2.f
    }
    
    fileprivate struct Font {
        static let textFieldFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let eventFont = UIFont.systemFont(ofSize: 10, weight: .medium)
    }
    
    // MARK: - UI
    let eventLabel = UILabel().then {
        $0.font = Font.eventFont
        $0.textAlignment = .left
    }
    
    let textField = UITextField().then {
        $0.clearButtonMode = .whileEditing
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.theme.tintColor = themed { $0.mainColor }
    }
    
    let separatorView = UIView().then {
        $0.backgroundColor = R.color.textFieldSeparatorColor()
    }
    
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.addSubview(self.eventLabel)
        self.addSubview(self.textField)
        self.addSubview(self.separatorView)
        
        self.eventLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        self.textField.snp.makeConstraints {
            $0.top.equalTo(self.eventLabel.snp.bottom).offset(Metric.textFieldTop)
            $0.left.equalToSuperview().offset(11)
            $0.right.equalToSuperview().offset(-11)
        }
        
        self.separatorView.snp.makeConstraints {
            $0.height.equalTo(Metric.separatorHeight)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalTo(self.textField.snp.bottom).offset(Metric.separatorTop)
        }
    }
    
    // MARK: - Configuring
    func bind() {
        
        self.textField.rx.controlEvent([.editingDidBegin]).asObservable()
            .subscribe(onNext: {
                UIView.animate(withDuration: 0.3) {
                    self.separatorView.theme.backgroundColor = themed { $0.mainColor }
                }
            })
            .disposed(by: disposeBag)
        
        self.textField.rx.controlEvent([.editingDidEnd]).asObservable()
            .subscribe(onNext: {
                UIView.animate(withDuration: 0.3) {
                    self.separatorView.backgroundColor = R.color.textFieldSeparatorColor()
                }
            })
            .disposed(by: disposeBag)
            
    }
    
}
