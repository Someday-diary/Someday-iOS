//
//  DiaryTextView.swift
//  diary
//
//  Created by 김부성 on 2021/12/28.
//

import UIKit
import RxSwift

final class DiaryTextView: UIView {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    public var placeholder: String? {
        get {
            self.placeholderTextView.text
        }
        set(value) {
            self.placeholderTextView.text = value
        }
    }
    
    public var title: String? {
        get {
            self.titleLabel.text
        }
        set(value) {
            self.titleLabel.text = value
        }
    }
    
    public var lines: Int {
        get {
            self.textView.textContainer.maximumNumberOfLines
        }
        set(value) {
            self.textView.textContainer.maximumNumberOfLines = value
        }
    }
    
    public var isScrollEnabled: Bool {
        get {
            self.textView.isScrollEnabled
        }
        set(value) {
            self.textView.isScrollEnabled = value
        }
    }
    
    // MARK: - Constants
    fileprivate struct Style {
        static let cornerRadius = 8.f
        static var backgroundColor = R.color.background2()
        static var selectedColor = R.color.background1()
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let textFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    }

    // MARK: - UI
    private let titleLabel: UILabel = UILabel().then {
        $0.font = Font.titleFont
        $0.textColor = R.color.description2()
    }
    
    private let background: UIView = UIView().then {
        $0.backgroundColor = Style.backgroundColor
        $0.layer.cornerRadius = Style.cornerRadius
    }
    
    private let placeholderTextView: UITextView = UITextView().then {
        $0.font = Font.textFont
        $0.backgroundColor = .clear
        $0.textColor = R.color.description1()
        $0.isEditable = false
        $0.isScrollEnabled = false
    }
    
    private let textView: UITextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.font = Font.textFont
    }
    
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.background)
        self.background.addSubview(self.placeholderTextView)
        self.background.addSubview(self.textView)
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(20)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        self.background.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        self.placeholderTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(12)
            $0.right.equalToSuperview().offset(-12)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        self.textView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(12)
            $0.right.equalToSuperview().offset(-12)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
    }
    
    private func bind() {
        self.textView.rx.didBeginEditing.asDriver()
            .drive(onNext:{ [weak self] in
                guard let self = self else { return }
                UIView.animate(withDuration: 0.2) {
                    self.placeholderTextView.isHidden = true
                    self.background.backgroundColor = Style.selectedColor
                }
            })
            .disposed(by: disposeBag)
        
        self.textView.rx.didEndEditing.asDriver()
            .drive(onNext:{ [weak self] in
                guard let self = self else { return }
                UIView.animate(withDuration: 0.3) {
                    if self.textView.text.isEmpty {
                        self.placeholderTextView.isHidden = false
                    }
                    self.background.backgroundColor = Style.backgroundColor
                }
            })
            .disposed(by: disposeBag)
    }
    
}

