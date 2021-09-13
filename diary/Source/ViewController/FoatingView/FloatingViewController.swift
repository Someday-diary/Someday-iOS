//
//  FloatingViewController.swift
//  diary
//
//  Created by 김부성 on 2021/09/10.
//


import UIKit

import RxAnimated
import ReactorKit

final class FloatingViewController: BaseViewController, View {
    
    typealias Reactor = FloatingViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        // MainView
        static let side = 30.f
        
        // HeaderView
        static let headerTop = 20.f
        static let headerHeight = 30.f
        
        // DateView
        static let dateViewTop = 25.f
        static let dateViewSize = 30.f
    }
    
    fileprivate struct Font {
        // Date Label
        static let dateFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        // Edit Button
        static let buttonFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    
    // MARK: - Properties
    
    // MARK: - UI
    let headerView = UIView()
    
    let dateView = UIView().then {
        $0.theme.backgroundColor = themed { $0.mainColor }
        $0.layer.cornerRadius = Metric.dateViewSize / 2
        $0.clipsToBounds = true
    }
    
    let dateLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = Font.dateFont
        $0.text = "24"
    }
    
    let editButton = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = Font.buttonFont
    }
    
    let textView = UITextView().then {
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.theme.backgroundColor = themed { $0.subColor }
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.textView)
        self.headerView.addSubview(self.dateView)
        self.headerView.addSubview(self.editButton)
        self.dateView.addSubview(self.dateLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.headerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.side)
            $0.right.equalToSuperview().offset(-Metric.side)
            $0.height.equalTo(Metric.headerHeight)
            $0.top.equalToSuperview().offset(Metric.headerTop)
        }

        self.textView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.side)
            $0.right.equalToSuperview().offset(-Metric.side)
            $0.top.equalTo(self.headerView.snp.bottom).offset(Metric.dateViewTop)
            $0.bottom.equalToSuperview().offset(-60)
        }

        self.dateView.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.width.height.equalTo(Metric.dateViewSize)
        }

        self.dateLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.editButton.snp.makeConstraints {
            $0.right.centerY.equalToSuperview()
        }
        
    }
    
    // MARK: - Configuring
    func bind(reactor: FloatingViewReactor) {
        reactor.state.map { $0.selectedDay.date }
            .bind(animated: self.dateLabel.rx.animated.flip(.top, duration: 0.3).text)
            .disposed(by: disposeBag)
    }
}
