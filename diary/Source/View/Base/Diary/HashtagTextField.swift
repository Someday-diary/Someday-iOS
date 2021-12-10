//
//  HashTagTextField.swift
//  diary
//
//  Created by 김부성 on 2021/09/06.
//

import UIKit
import RxSwift
import RxCocoa

final class HashtagTextField: UIView {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()

    // MARK: - Constants
    fileprivate struct Metric {
        // separator
        static let separatorTop = 3.f
        static let separatorHeight = 1.f
    }
    
    fileprivate struct Font {
        static let textFieldFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    // MARK: - UI
    let textField = UITextField().then {
        $0.theme.tintColor = themed { $0.thirdColor }
        $0.theme.textColor = themed { $0.thirdColor }
        $0.font = Font.textFieldFont
        $0.placeholder = "# Write Tags"
        $0.autocorrectionType = .default
        $0.autocapitalizationType = .none
        $0.clearButtonMode = .whileEditing
        $0.theme.clearButtonTintColor = themed { $0.clearButtonColor }
    }
    
    let separatorView = UIView().then {
        $0.theme.backgroundColor = themed { $0.thirdColor }
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
        self.addSubview(self.textField)
        self.addSubview(self.separatorView)
        
        self.textField.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        self.separatorView.snp.makeConstraints {
            $0.height.equalTo(Metric.separatorHeight)
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.textField.snp.bottom).offset(Metric.separatorTop)
        }
    }
    
    func bind() {
        self.textField.rx.text.orEmpty.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                if $0.last == " " { self?.textField.text?.append("#")}
            })
            .disposed(by: disposeBag)
        
        self.textField.rx.controlEvent([.editingDidBegin]).asObservable()
            .subscribe(onNext: { [weak self] in
                if self?.textField.text == "" {
                    self?.textField.text?.append("#")
                }
            })
            .disposed(by: disposeBag)
    }
    
}
