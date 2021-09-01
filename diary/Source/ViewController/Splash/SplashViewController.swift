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
        static let imageHeight = 291.f
        static let imageWidth = 315.f
        static let imageRight = 33.f
        static let imageBottom = 75.f
        
        // Title Label
        static let labelTop = 140.f
        static let labelLeft = 50.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 32, weight: .regular)
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    let splashImage = UIImageView().then {
        $0.image = R.image.mainIllustration()
    }
    
    let titleLabel = UILabel().then {
        $0.text = "DIARY"
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
        self.view.addSubview(self.splashImage)
        self.view.addSubview(self.titleLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.splashImage.snp.makeConstraints {
            $0.width.equalTo(Metric.imageWidth)
            $0.height.equalTo(Metric.imageHeight)
            $0.bottom.equalToSafeArea(self.view).offset(-Metric.imageBottom)
            $0.right.equalToSafeArea(self.view).offset(Metric.imageRight)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSafeArea(self.view).offset(Metric.labelTop)
            $0.left.equalToSafeArea(self.view).offset(Metric.labelLeft)
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
