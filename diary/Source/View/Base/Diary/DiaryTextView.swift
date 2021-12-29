//
//  DiaryTextView.swift
//  diary
//
//  Created by 김부성 on 2021/12/28.
//

import UIKit
import RxSwift
import PinLayout

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
        self.addSubview(self.placeholderTextView)
        self.addSubview(self.textView)
        
        self.titleLabel.pin.topLeft().topRight().height(20)
        
        self.background.pin.below(of: self.titleLabel).bottom().left().right()
            .marginTop(4)
        
        self.placeholderTextView.pin
            .topStart(to: self.background.anchor.topStart)
            .bottomEnd(to: self.background.anchor.bottomEnd)
            .margin(8, 8, 12, 12)
        
        self.textView.pin
            .topStart(to: self.background.anchor.topStart)
            .bottomEnd(to: self.background.anchor.bottomEnd)
            .margin(8, 8, 12, 12)
    }
    
    private func bind() {
        self.textView.rx.didBeginEditing.asDriver()
            .drive(onNext:{
                UIView.animate(withDuration: 0.2) {
                    self.placeholderTextView.isHidden = true
                    self.background.backgroundColor = Style.selectedColor
                }
            })
            .disposed(by: disposeBag)
        
        self.textView.rx.didEndEditing.asDriver()
            .drive(onNext:{
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

