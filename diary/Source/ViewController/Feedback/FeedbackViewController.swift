//
//  FeedbackViewController.swift
//  diary
//
//  Created by 김부성 on 2021/12/27.
//

import UIKit

import PinLayout
import ReactorKit

final class FeedbackViewController: BaseViewController, View {
    
    typealias Reactor = FeedbackViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        
    }
    
    fileprivate struct Font {
        
    }
    
    fileprivate struct Style {
        
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    private let titleTextView: DiaryTextView = DiaryTextView().then {
        $0.placeholder = "제목"
        $0.title = "제목"
        $0.isScrollEnabled = false
        $0.lines = 1
    }
    
    private let feedbackTextView: DiaryTextView = DiaryTextView().then {
        $0.placeholder = "내용을 입력하세요"
        $0.title = "피드백"
        $0.lines = 0
        $0.isScrollEnabled = true
    }
    
    private let sendButton: DiarySecondButton = DiarySecondButton(type: .system).then {
        $0.setTitle("전송하기", for: .normal)
        $0.isEnabled = true
    }
    
    // MARK: - Inintializing
    init(reactor: Reactor) {
        super.init()
        defer {
            self.reactor = reactor
        }
        
        self.title = "피드백"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(self.titleTextView)
        self.view.addSubview(self.feedbackTextView)
        self.view.addSubview(self.sendButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.titleTextView.pin
            .top(self.view.pin.safeArea)
            .left(7%)
            .right(7%)
            .height(75)
            .marginTop(10)
        
        self.feedbackTextView.pin
            .below(of: self.titleTextView)
            .left(7%)
            .right(7%)
            .height(50%)
            .marginTop(20)
        
        self.sendButton.pin
            .bottom(self.view.pin.safeArea)
            .left(7%)
            .right(7%)
            .height(45)
    }
    
    // MARK: - Configuring
    func bind(reactor: Reactor) {
        
    }
}

