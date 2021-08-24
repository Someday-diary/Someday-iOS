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
    
    let disposeBag = DisposeBag()

    // MARK: Constants
    struct Metric {
        static let textFieldTop = 10.f
        static let separatorTop = 5.f
        static let separatorHeight = 2.f
    }
    
    struct Font {
        static let textFieldFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let eventFont = UIFont.systemFont(ofSize: 10, weight: .medium)
    }
    
    // MARK: UI
    let eventLabel = UILabel().then {
        $0.font = Font.eventFont
        $0.textAlignment = .left
    }
    
    let textField = UITextField().then {
        $0.clearButtonMode = .whileEditing
        $0.autocorrectionType = .no
    }
    
    let separatorView = UIView().then {
        $0.backgroundColor = R.color.separatorColor()
    }
    
    // MARK: Initializing
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
    
    func bind() {
        self.textField.rx.text.orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                UIView.animate(withDuration: 0.3) {
                    self?.separatorView.backgroundColor = text.isEmpty ? R.color.separatorColor() : R.color.mainColor()
                }
            })
            .disposed(by: disposeBag)
    }
    
}
