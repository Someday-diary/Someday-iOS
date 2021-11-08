//
//  PasswordViewController.swift
//  diary
//
//  Created by 김부성 on 2021/11/08.
//

import UIKit

import Atributika
import RxKeyboard
import ReactorKit

final class PasswordViewController: BaseViewController, View {
    
    typealias Reactor = PasswordViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        
        // Image
        static let imageRatio = (50 / 70).f
        static let imageHeight = 70.f
        static let imageWidth = 50.f
        static let imageTop = 60.f
        
        // TextField
        static let textFieldSide = 30.f
        static let textFieldHeight = 50.f
        static let textFieldBetween = 15.f
        
        // Register
        static let registerHeight = 40.f
        static let registerSide = 30.f
        static let registerBottom = 10.f
        
        // Login
        static let loginBottom = 70.f
        static let loginHeight = 20.f
        static let loginKeyboard = 10.f
    }
    
    fileprivate struct Font {
        // Register Button
        static let registerFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        // Login Button
        static let loginHighlight = Style("h")
            .font(.systemFont(ofSize: 14, weight: .bold))
            .underlineStyle(.single)
        static let loginAll = Style.font(.systemFont(ofSize: 14)).foregroundColor(R.color.systemBlackColor()!)
        
        // TextField
        static let textFieldAll = Style.font(.systemFont(ofSize: 14)).foregroundColor(R.color.textFieldTextColor()!)
    }
    
    // MARK: - UI
    let passwordImageView = UIImageView().then {
        $0.theme.image = themed { $0.mainIllustration }
    }
    
    let passwordTextField = DiaryTextField().then {
        $0.textField.attributedPlaceholder = "비밀번호".styleAll(Font.textFieldAll).attributedString
        $0.textField.keyboardType = .default
        $0.textField.isSecureTextEntry = true
    }
    
    let reEnterTextField = DiaryTextField().then {
        $0.textField.attributedPlaceholder = "비밀번호 확인".styleAll(Font.textFieldAll).attributedString
        $0.textField.keyboardType = .default
        $0.textField.isSecureTextEntry = true
    }
    
    let registerButton = DiaryButton(type: .system).then {
        $0.setTitle("회원가입 하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = Font.registerFont
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
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(self.passwordImageView)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.reEnterTextField)
        self.view.addSubview(self.registerButton)
        self.view.addSubview(self.loginButton)
        
        // Bind
        self.UIBind()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.passwordImageView.snp.makeConstraints {
            $0.height.equalTo(Metric.imageHeight)
            $0.width.equalTo(Metric.imageWidth)
            $0.centerX.equalToSafeArea(self.view)
        }
        
        self.passwordTextField.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.textFieldSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.textFieldSide)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.reEnterTextField.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.textFieldSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.textFieldSide)
            $0.top.equalTo(self.passwordTextField.snp.bottom).offset(Metric.textFieldBetween.authTextFieldBetween)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.registerButton.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.registerSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.registerSide)
            $0.height.equalTo(Metric.registerHeight)
            $0.bottom.equalTo(self.loginButton.snp.top).offset(-Metric.registerBottom)
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
    func bind(reactor: PasswordViewReactor) {
        // Input
        Observable.combineLatest(
            passwordTextField.textField.rx.text.orEmpty,
            reEnterTextField.textField.rx.text.orEmpty
        )
        .observeOn(MainScheduler.asyncInstance)
        .map { Reactor.Action.updateTextField([$0, $1]) }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        self.registerButton.rx.tap.asObservable()
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
        let passwordValidation = reactor.state.map { $0.passwordValidation }.distinctUntilChanged()
        let reEnterValidation = reactor.state.map { $0.reEnterValidation }.distinctUntilChanged()
        
        Observable.combineLatest(
            passwordValidation.map { $0 == .correct(.password) },
            reEnterValidation.map { $0 == .correct(.reEnter) }
        ) { $0 && $1 }
        .bind(to: registerButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        reactor.state.map { $0.passwordValidation }
            .distinctUntilChanged()
            .bind(to: self.passwordTextField.rx.animated.fade(duration: 0.3).error)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.reEnterValidation }
            .distinctUntilChanged()
            .bind(to: self.reEnterTextField.rx.animated.fade(duration: 0.3).error)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}

extension PasswordViewController {
    fileprivate func UIBind() {
        RxKeyboard.instance.visibleHeight
            .distinctUntilChanged()
            .drive(onNext: { [weak self] height in
                guard let `self` = self else { return }
                
                // update
                self.passwordImageView.snp.updateConstraints {
                    $0.top.equalToSafeArea(self.view).offset(height == 0 ? self.view.frame.height/20 : -25)
                }
                
                self.passwordTextField.snp.updateConstraints {
                    $0.top.equalTo(self.passwordImageView.snp.bottom).offset(height == 0 ? self.view.frame.height / 10 : ((self.view.frame.height - height) / 12).authTextFieldTop )
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
        
        themed { $0.thirdColor }.asObservable()
            .distinctUntilChanged()
            .subscribe (onNext: { [weak self] color in
                guard let `self` = self else { return }
                let text = "오늘 하루 회원이신가요? <h>로그인하기</h>".style(tags: Font.loginHighlight.foregroundColor(color)).styleAll(Font.loginAll).attributedString
                self.loginButton.setAttributedTitle(text, for: .normal)
            })
            .disposed(by: disposeBag)
    }
}
