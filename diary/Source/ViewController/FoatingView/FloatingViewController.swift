//
//  FloatingViewController.swift
//  diary
//
//  Created by 김부성 on 2021/09/10.
//


import UIKit

import ActiveLabel
import RxAnimated
import ReactorKit

final class FloatingViewController: BaseViewController, View {
    
    typealias Reactor = FloatingViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        // MainView
        static let side = 30.f
        
        // HeaderView
        static let headerTop = 30.f
        static let headerHeight = 70.f
        
        // DateView
        static let dateViewTop = 35.f
        static let dateViewSize = 30.f
    }
    
    fileprivate struct Font {
        // Date Label
        static let dateFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        // Edit Button
        static let buttonFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        // Text View
        static let textViewFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        // Tag Label
        static let tagLabelFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
    
    let createButton = UIButton().then {
        $0.setTitle("일기 작성", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = Font.buttonFont
    }
    
    let editButton = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = Font.buttonFont
    }
    
    let hashtagLabel = ActiveLabel().then {
        $0.enabledTypes = [.hashtag]
        $0.theme.textColor = themed { $0.thirdColor }
        $0.theme.hashtagColor = themed { $0.thirdColor }
        $0.font = Font.tagLabelFont
        $0.adjustsFontForContentSizeCategory = true
        $0.handleHashtagTap {
            print("\($0) tapped")
        }
        $0.configureLinkAttribute = { type, attributes, isSelected in
            var atts = attributes
            switch type {
            case .hashtag:
                atts[NSAttributedString.Key.font] = Font.tagLabelFont
            default: ()
            }
            return atts
        }
    }
    
    let textView = UITextView().then {
        $0.isEditable = false
        $0.backgroundColor = .clear
        $0.font = Font.textViewFont
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
        
        self.view.backgroundColor = .clear
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.textView)
        self.headerView.addSubview(self.dateView)
        self.headerView.addSubview(self.hashtagLabel)
        self.headerView.addSubview(self.createButton)
        self.headerView.addSubview(self.editButton)
        self.dateView.addSubview(self.dateLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.headerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.side)
            $0.right.equalToSuperview().offset(-Metric.side)
            $0.height.equalTo(Metric.headerHeight)
            $0.top.equalToSuperview()//.offset(Metric.headerTop)
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
        
        self.hashtagLabel.snp.makeConstraints {
            $0.left.equalTo(self.dateView.snp.right).offset(15)
            $0.right.equalTo(self.editButton.snp.left).offset(-5)
            $0.centerY.equalToSuperview()
        }

        self.editButton.snp.makeConstraints {
            $0.right.centerY.equalToSuperview()
            $0.width.equalTo(50)
        }
        
        self.createButton.snp.makeConstraints {
            $0.right.centerY.equalToSuperview()
            $0.width.equalTo(70)
        }
        
    }
    
    // MARK: - Configuring
    func bind(reactor: FloatingViewReactor) {
        // Input
        self.createButton.rx.tap.asObservable()
            .map { Reactor.Action.write }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.rx.viewDidLoad.asObservable()
            .map { _ in Reactor.Action.updateDiary }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        reactor.state.map { $0.selectedDay.date }
            .bind(animated: self.dateLabel.rx.animated.flip(.top, duration: 0.3).text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.diaryData }
            .bind(to: self.textView.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.diaryTags }
            .distinctUntilChanged()
            .bind(to: self.hashtagLabel.rx.animated.fade(duration: 0.2).text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.createState }
            .distinctUntilChanged()
            .map { !$0 }
            .bind(to: self.createButton.rx.animated.flip(.top, duration: 0.3).isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.createState }
            .distinctUntilChanged()
            .bind(to: self.editButton.rx.animated.flip(.top, duration: 0.3).isHidden)
            .disposed(by: disposeBag)
    }
}
