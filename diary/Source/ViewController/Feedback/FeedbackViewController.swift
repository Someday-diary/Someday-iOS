//
//  FeedbackViewController.swift
//  diary
//
//  Created by 김부성 on 2021/12/27.
//

import UIKit

import RxKeyboard
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
        $0.isScrollEnabled = true
    }
    
    private let sendButton: DiarySecondButton = DiarySecondButton(type: .system).then {
        $0.setTitle("전송하기", for: .normal)
        $0.isEnabled = false
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
        
        UIBind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.titleTextView.snp.makeConstraints {
            $0.top.equalToSafeArea(self.view).offset(10)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.height.equalTo(75)
        }
        
        self.feedbackTextView.snp.makeConstraints {
            $0.top.equalTo(self.titleTextView.snp.bottom).offset(20)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }
        
        self.sendButton.snp.makeConstraints {
            $0.top.equalTo(self.feedbackTextView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
    }
    
    // MARK: - Configuring
    func bind(reactor: Reactor) {
        
    }
    
    
}

extension FeedbackViewController {
    fileprivate func UIBind() {
        RxKeyboard.instance.visibleHeight
            .distinctUntilChanged()
            .drive(onNext: { [weak self] height in
                guard let self = self else { return }
                
                self.sendButton.snp.updateConstraints {
                    $0.bottom.equalToSafeArea(self.view).offset(height == 0 ? -25 : -height)
                }
                self.sendButton.setNeedsUpdateConstraints()
                
                UIView.animate(withDuration: 0.1) {
                    self.view.layoutIfNeeded()
                }
                
            })
            .disposed(by: disposeBag)
    }
}

