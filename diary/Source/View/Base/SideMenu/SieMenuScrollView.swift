//
//  SideMenuScrollView.swift
//  diary
//
//  Created by 김부성 on 2021/09/23.
//

import UIKit

final class SideMenuScrollView: UIView {
    
    // MARK: - Constants
    fileprivate struct Metric {
        static let contentArea = 40.f
        static let buttonTop = 25.f
    }
    
    fileprivate struct Font {
        
    }
    
    // MARK: - UI
    let scrollView = UIScrollView()
    
    let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let gradient = CAGradientLayer().then {
        $0.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        $0.locations = [0, 0.1, 0.9, 1]
    }
    
    let themeButton = DiarySideMenuListButton().then {
        $0.icon.image = R.image.themeIcon()
        $0.label.text = "Theme Setting".localized
    }
    
//    let alarmButton = DiarySideMenuListButton().then {
//        $0.icon.image = R.image.alarmIcon()
//        $0.label.text = "일기 알람 설정"
//    }
    
    let lockButton = DiarySideMenuListButton().then {
        $0.icon.image = R.image.lockIcon()
        $0.label.text = "Lock Setting".localized
    }
    
    let infoButton = DiarySideMenuListButton().then {
        $0.icon.image = R.image.openSourceIcon()
        $0.label.text = "Open-source license".localized
    }
    
    let feedbackButton = DiarySideMenuListButton().then {
        $0.icon.image = R.image.feedbackIcon()
        $0.label.text = "Contect Us".localized
    }
    
    // MARK: - Inititalizing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.scrollView.showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Gradient
        self.layer.mask = gradient
        gradient.frame = self.bounds
        
        // Scroll view
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        // Buttons
        self.contentView.addSubview(self.themeButton)
//        self.contentView.addSubview(self.alarmButton)
        self.contentView.addSubview(self.lockButton)
        self.contentView.addSubview(self.infoButton)
        self.contentView.addSubview(self.feedbackButton)
        
        
        self.scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        self.themeButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(Metric.contentArea)
        }
        
//        self.alarmButton.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//            $0.top.equalTo(self.themeButton.snp.bottom).offset(Metric.buttonTop)
//        }
        
        self.lockButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.themeButton.snp.bottom).offset(Metric.buttonTop)
        }
        
        self.infoButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.lockButton.snp.bottom).offset(Metric.buttonTop)
        }
        
        self.feedbackButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.infoButton.snp.bottom).offset(Metric.buttonTop)
            $0.bottom.equalToSuperview().offset(-Metric.contentArea)
        }
        
    }
    
}
