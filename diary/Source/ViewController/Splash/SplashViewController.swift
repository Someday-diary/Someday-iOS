//
//  SplashViewController.swift
//  diary
//
//  Created by 김부성 on 2021/08/25.
//

import UIKit
import RxViewController
import ReactorKit

class SplashViewController: BaseViewController, View {
    
    typealias Reactor = SplashViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        // Image
        static let imageHeight = 130.f
        static let imageWidth = 94.f
        static let imageY = 50.f
        
        // Title Label
        static let labelTop = 30.f
        static let labelLeft = 50.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 28, weight: .light)
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    let splashImage = UIImageView().then {
        $0.theme.image = themed { $0.mainIllustration }
    }
    
    let titleLabel = UILabel().then {
        $0.text = "오늘 하루"
        $0.theme.textColor = themed { $0.thirdColor }
        $0.font = Font.titleFont
    }
    
    // MARK: - Inintializing
    init(reactor: Reactor) {
        super.init()
        defer {
            self.reactor = reactor
        }
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
        
        self.view.addSubview(self.splashImage)
        self.view.addSubview(self.titleLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.splashImage.snp.makeConstraints {
            $0.width.equalTo(Metric.imageWidth)
            $0.height.equalTo(Metric.imageHeight)
            $0.centerY.equalToSafeArea(self.view).offset(-Metric.imageY)
            $0.centerX.equalToSafeArea(self.view)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.splashImage.snp.bottom).offset(Metric.labelTop)
            $0.centerX.equalToSafeArea(self.view)
        }
        
    }
    
    // MARK: - Configuring
    func bind(reactor: SplashViewReactor) {

        self.rx.viewDidAppear.asObservable()
            .map { _ in Reactor.Action.setNextView }
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
