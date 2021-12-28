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
            self.placeholderLabel.text
        }
        set(value) {
            self.placeholderLabel.text = value
        }
    }
    
    // MARK: - Constants
    fileprivate struct Style {
        static let cornerRadius = 8.f
        static var backgroundColor = R.color.background2()
        static var selectedColor = R.color.background1()
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 12, weight: .medium)
        static let placeholderFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    // MARK: - UI
    private let titleLabel: UILabel = UILabel().then {
        $0.font = Font.titleFont
    }
    
    private let placeholderLabel: UILabel = UILabel().then {
        $0.font = Font.placeholderFont
    }
    
    private let textView: UITextView = UITextView().then {
        $0.layer.cornerRadius = Style.cornerRadius
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
        self.addSubview(self.textView)
        self.addSubview(self.placeholderLabel)
        
        self.titleLabel.pin.start().end().top()
        self.textView.pin.below(of: self.titleLabel).start().end().bottom()
        self.placeholderLabel.pin.above(of: self.textView).topStart(to: self.textView.anchor.topStart)
    }
    
    private func bind() {
        
    }
    
}

