//
//  LockViewController.swift
//  diary
//
//  Created by 김부성 on 2021/11/09.
//

import UIKit
import RxViewController
import ReactorKit

class LockViewController: BaseViewController, View {
    
    typealias Reactor = LockViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        static let cellHeight = 50.f
        static let cellSide = 32.f
    }
    
    fileprivate struct Font {
        static let cellFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    let lockSwitch = UISwitch().then {
        $0.tintColor = R.color.tableViewCellColor()
        $0.onTintColor = R.color.themeSelectionColor()
    }
    
    let lockLabel = UILabel().then {
        $0.text = "Lock Setting".localized
        $0.font = Font.cellFont
    }
    
    let lockCell = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let lockWithBioLabel = UILabel().then {
        $0.text = "Biometric ID (Touch ID, Face ID)".localized
        $0.font = Font.cellFont
    }
    
    let lockWithBioSwitch = UISwitch().then {
        $0.tintColor = R.color.tableViewCellColor()
        $0.onTintColor = R.color.themeSelectionColor()
    }
    
    let lockWithBioCell = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let changePasscodeButton = UIButton(type: .system).then {
        $0.backgroundColor = .clear
    }
    
    let changePasscodeLabel = UILabel().then {
        $0.text = "Change Passcode".localized
        $0.font = Font.cellFont
    }
    
    let bottomView = UIView().then {
        $0.backgroundColor = R.color.tableViewCellColor()
    }
    
    // MARK: - Inintializing
    init(reactor: Reactor) {
        super.init()
        defer {
            self.reactor = reactor
        }
        
        self.title = "Lock Setting".localized
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
        
        self.view.addSubview(self.lockCell)
        self.view.addSubview(self.lockWithBioCell)
        self.view.addSubview(self.changePasscodeButton)
        self.lockCell.addSubview(self.lockLabel)
        self.lockCell.addSubview(self.lockSwitch)
        self.lockWithBioCell.addSubview(self.lockWithBioLabel)
        self.lockWithBioCell.addSubview(self.lockWithBioSwitch)
        self.changePasscodeButton.addSubview(self.changePasscodeLabel)
        self.view.addSubview(self.bottomView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.lockCell.snp.makeConstraints {
            $0.top.left.right.equalToSafeArea(self.view)
            $0.height.equalTo(Metric.cellHeight)
        }
        
        self.lockLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.cellSide)
            $0.centerY.equalToSuperview()
        }
        
        self.lockSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-Metric.cellSide)
        }
        
        self.lockWithBioCell.snp.makeConstraints {
            $0.top.equalTo(self.lockCell.snp.bottom)
            $0.left.right.equalToSafeArea(self.view)
            $0.height.equalTo(Metric.cellHeight)
        }
        
        self.lockWithBioLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.cellSide)
            $0.centerY.equalToSuperview()
        }
        
        self.lockWithBioSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-Metric.cellSide)
        }
        
        self.changePasscodeButton.snp.makeConstraints {
            $0.top.equalTo(self.lockWithBioCell.snp.bottom)
            $0.left.right.equalToSafeArea(self.view)
            $0.height.equalTo(Metric.cellHeight)
        }
        
        self.changePasscodeLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.cellSide)
            $0.centerY.equalToSuperview()
        }
        
        self.bottomView.snp.makeConstraints {
            $0.top.equalTo(self.changePasscodeButton.snp.bottom).offset(25)
            $0.left.right.equalToSafeArea(self.view)
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: Reactor) {
        
        self.rx.viewDidAppear.asObservable()
            .map { _ in Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.lockSwitch.rx.controlEvent(.valueChanged)
            .withLatestFrom(lockSwitch.rx.value)
            .map { Reactor.Action.changeLock($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.lockWithBioSwitch.rx.controlEvent(.valueChanged)
            .withLatestFrom(lockWithBioSwitch.rx.value)
            .map { Reactor.Action.changeBio($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.changePasscodeButton.rx.tap.asObservable()
            .map { Reactor.Action.changePasscode }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.lockIsOn }.asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.lockSwitch.isOn = $0
                self.changePasscodeButton.isEnabled = $0
                
                if $0 {
                    self.lockLabel.textColor = .none
                    self.changePasscodeLabel.textColor = .none
                } else {
                    self.lockLabel.textColor = R.color.diaryDisabledColor()
                    self.changePasscodeLabel.textColor = R.color.diaryDisabledColor()
                }
                
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.lockIsOn && $0.bioIsEnabled }.asObservable()
            .bind(to: self.lockWithBioSwitch.rx.isEnabled)
            .disposed(by: disposeBag)
            
        reactor.state.map { $0.bioIsOn }.asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                self.lockWithBioSwitch.isOn = $0
                self.lockWithBioLabel.textColor = $0 ? .none : R.color.diaryDisabledColor()
            }).disposed(by: disposeBag)
    }
}
