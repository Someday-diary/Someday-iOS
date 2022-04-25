//
//  RegisterViewController.swift
//  diary
//
//  Created by 김부성 on 2021/11/08.
//

import UIKit

import Atributika
import RxKeyboard
import ReactorKit

final class RegisterViewController: BaseViewController, View {
    
    typealias Reactor = RegisterViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        
        // Image
        static let imageHeight = 50.f
        static let imageWidth = 50.f
        static let imageTop = 60.f
        
        // TextField
        static let textFieldSide = 30.f
        static let textFieldHeight = 50.f
        static let textFieldBetween = 15.f
        
        // Code
        static let codeHeight = 35.f
        static let codeWidth = 60.f
        
        // next
        static let nextHeight = 40.f
        static let nextSide = 30.f
        static let nextBottom = 10.f
        
        // Login
        static let loginBottom = 70.f
        static let loginHeight = 20.f
        static let loginKeyboard = 10.f
    }
    
    fileprivate struct Font {
        // Next Button
        static let nextFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        static let codeFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        // Login Button
        static let loginHighlight = Style("h")
            .font(.systemFont(ofSize: 14, weight: .bold))
            .underlineStyle(.single)
        static let loginAll = Style.font(.systemFont(ofSize: 14)).foregroundColor(R.color.systemBlackColor()!)
        
        // TextField
        static let textFieldAll = Style.font(.systemFont(ofSize: 14)).foregroundColor(R.color.textFieldTextColor()!)
    }
    
    // MARK: - UI
    let signUpImageView = UIImageView().then {
        $0.theme.image = themeService.attribute { $0.mainIllustration }
    }
    
    let emailTextField = DiaryTextField().then {
        $0.textField.attributedPlaceholder = "Email".localized.styleAll(Font.textFieldAll).attributedString
        $0.textField.keyboardType = .emailAddress
    }
    
    let codeTextField = DiaryTextField().then {
        $0.textField.attributedPlaceholder = "Verification Code".localized.styleAll(Font.textFieldAll).attributedString
        $0.textField.keyboardType = .numberPad
    }
    
    let codeButton = SendCodeButton().then {
        $0.setTitle("Verify".localized, for: .normal)
    }
    
    let nextButton = DiaryButton(type: .system).then {
        $0.setTitle("Next".localized, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = Font.nextFont
    }
    
    let loginButton = UIButton(type: .system).then {
        $0.backgroundColor = .clear
    }
    
    // MARK: - Initializing
    init(reactor: Reactor) {
        super.init()
        
        defer { self.reactor = reactor }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backButtonDisplayMode = .minimal
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(self.signUpImageView)
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.codeButton)
        self.view.addSubview(self.codeTextField)
        self.view.addSubview(self.nextButton)
        self.view.addSubview(self.loginButton)
        
        // Bind
        self.UIBind()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.signUpImageView.snp.makeConstraints {
            $0.height.equalTo(Metric.imageHeight)
            $0.width.equalTo(Metric.imageWidth)
            $0.centerX.equalToSafeArea(self.view)
        }
        
        self.emailTextField.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.textFieldSide)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.codeButton.snp.makeConstraints {
            $0.height.equalTo(Metric.codeHeight)
            $0.width.equalTo(Metric.codeWidth)
            $0.right.equalToSuperview().offset(-Metric.textFieldSide)
            $0.left.equalTo(self.emailTextField.snp.right).offset(15)
            $0.centerY.equalTo(self.emailTextField)
        }
        
        self.codeTextField.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.textFieldSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.textFieldSide)
            $0.top.equalTo(self.emailTextField.snp.bottom).offset(Metric.textFieldBetween.authTextFieldBetween)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.nextButton.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.nextSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.nextSide)
            $0.height.equalTo(Metric.nextHeight)
            $0.bottom.equalTo(self.loginButton.snp.top).offset(-Metric.nextBottom)
        }
        
        self.loginButton.snp.makeConstraints {
            $0.centerX.equalToSafeArea(self.view)
            $0.height.equalTo(Metric.loginHeight)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    // MARK: - Configuring
    func bind(reactor: RegisterViewReactor) {
        // Input
        Observable.combineLatest(
            emailTextField.textField.rx.text.orEmpty,
            codeTextField.textField.rx.text.orEmpty
        )
        .observe(on: MainScheduler.asyncInstance)
        .map { Reactor.Action.updateTextField([$0, $1]) }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        self.codeButton.rx.tap.asObservable()
            .map { [weak self] in
                self?.view.endEditing(true)
                return Reactor.Action.sendCode
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.nextButton.rx.tap.asObservable()
            .map { [weak self] in
                self?.view.endEditing(true)
                return Reactor.Action.next
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.loginButton.rx.tap.asObservable()
            .map { Reactor.Action.login }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        let emailValidation = reactor.state.map { $0.emailValidation }.distinctUntilChanged()
        let codeValidation = reactor.state.map { $0.codeValidation }.distinctUntilChanged()
        
        Observable.combineLatest(
            emailValidation.map { $0 == .correct(.email) },
            codeValidation.map { $0 == .correct(.code) }
        ) { $0 && $1 }
        .bind(to: nextButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        emailValidation.map { $0 == .correct(.email) }
            .distinctUntilChanged()
            .bind(to: self.codeButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        emailValidation
            .bind(to: self.emailTextField.rx.animated.fade(duration: 0.3).error)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.codeValidation }
            .distinctUntilChanged()
            .bind(to: self.codeTextField.rx.animated.fade(duration: 0.3).error)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}

extension RegisterViewController {
    fileprivate func UIBind() {
        RxKeyboard.instance.visibleHeight
            .distinctUntilChanged()
            .drive(onNext: { [weak self] height in
                guard let `self` = self else { return }
                
                // update
                self.signUpImageView.snp.updateConstraints {
                    $0.top.equalToSafeArea(self.view).offset(height == 0 ? self.view.frame.height/20 : -25)
                }
                
                self.emailTextField.snp.updateConstraints {
                    $0.top.equalTo(self.signUpImageView.snp.bottom).offset(height == 0 ? self.view.frame.height / 10 : ((self.view.frame.height - height) / 12).authTextFieldTop )
                }
                
                self.loginButton.snp.updateConstraints {
                    $0.bottom.equalToSafeArea(self.view).offset(height == 0 ? -self.view.frame.height / 20 : -height-Metric.loginKeyboard)
                }
                
                // animation
                UIView.animate(withDuration: 0.1) {
                    self.view.layoutIfNeeded()
                }
                
            })
            .disposed(by: disposeBag)
        
        themeService.attribute { $0.thirdColor }.stream
            .distinctUntilChanged()
            .subscribe (onNext: { [weak self] in
                guard let self = self else { return }
                let text = "Already have account? <h>Sign in</h>".localized.style(tags: Font.loginHighlight.foregroundColor($0)).styleAll(Font.loginAll).attributedString
                self.loginButton.setAttributedTitle(text, for: .normal)
            })
            .disposed(by: disposeBag)
    }
}
