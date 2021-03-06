//
//  WriteViewController.swift
//  diary
//
//  Created by 김부성 on 2021/09/04.
//

import UIKit

import UITextView_Placeholder
import ReactorKit
import RxKeyboard

final class WriteViewController: BaseViewController, ReactorKit.View {
    
    // MARK: - Properties
    typealias Reactor = WriteViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        
        // ButtonPadding
        static let leftNavigativePadding = 18.f
        static let rightNavigativePadding = 20.f
        
        // TextView
        static let textViewTop = 50.f
        static let textViewBottom = 50.f
        static let textViewSide = 32.f
        
        // HashtagTextField
        static let textFieldTop = 50.f
        static let textFieldBottom = 40.f
        static let textFieldSide = 32.f
        static let textFieldHeight = 25.f
    }
    
    fileprivate struct Font {
        static let textViewFont = UIFont.systemFont(ofSize: 16, weight: .light)
    }
    
    // MARK: - UI
    let textView = UITextView().then {
        $0.theme.placeholderColor = themed { $0.mainColor }
        $0.backgroundColor = R.color.diaryBackgroundColor()
        $0.placeholder = "Write down your today".localized
        $0.theme.tintColor = themed { $0.mainColor }
        $0.font = Font.textViewFont
        $0.isScrollEnabled = true
    }
    
    let hashtagTextField = HashtagTextField()
    
    let leftNavigativePadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil).then {
        $0.width = Metric.leftNavigativePadding
    }
    
    let rightNavigativePadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil).then {
        $0.width = Metric.rightNavigativePadding
    }
    
    let backButton = UIBarButtonItem(image: R.image.backButton(), style: .done, target: nil, action: nil).then {
        $0.tintColor = R.color.navigationButtonColor()
    }
    
    let submitButton = UIBarButtonItem(image: nil, style: .done, target: nil, action: nil).then {
        $0.title = "Save".localized
        $0.tintColor = R.color.navigationButtonColor()
    }
    
    // MARK: - Inintializing
    init(reactor: WriteViewReactor) {
        super.init()
        
        defer { self.reactor = reactor }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layoutIfNeeded()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.navigationItem.leftBarButtonItems = [leftNavigativePadding, backButton]
        self.navigationItem.rightBarButtonItems = [rightNavigativePadding, submitButton]
        self.title = self.reactor?.currentState.date.toString
        self.view.addSubview(textView)
        self.view.addSubview(hashtagTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        self.view.endEditing(true)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.textView.snp.makeConstraints {
            $0.top.equalToSafeArea(self.view).offset(Metric.textViewTop)
            $0.left.equalToSafeArea(self.view).offset(Metric.textViewSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.textViewSide)
            $0.bottom.equalTo(self.hashtagTextField.snp.top).offset(-Metric.textViewBottom)
        }
        
        self.hashtagTextField.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.textFieldSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.textFieldSide)
            $0.top.equalTo(self.textView.snp.bottom).offset(Metric.textFieldTop)
            $0.height.equalTo(Metric.textFieldHeight)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: WriteViewReactor) {
        
        // input
        self.backButton.rx.tap.asObservable()
            .map { Reactor.Action.popViewController }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.submitButton.rx.tap.asObservable()
            .map { [weak self] in
                self?.view.endEditing(true)
                return Reactor.Action.saveDidary(self?.textView.text ?? "", self?.hashtagTextField.textField.text ?? "")
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // output
        reactor.state.map { $0.data }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.textView.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.tags }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.hashtagTextField.textField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        themed { $0.thirdColor }.asObservable()
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.hashtagTextField.textField.setPlaceholderColor($0)
            })
            .disposed(by: disposeBag)
        
        // view
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyboardHeight in
                guard let `self` = self else { return }
                self.hashtagTextField.snp.updateConstraints {
                    $0.bottom.equalToSafeArea(self.view).offset(-keyboardHeight-Metric.textFieldBottom)
                }
                self.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }
    
}
