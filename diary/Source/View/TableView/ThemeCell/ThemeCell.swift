//
//  AppearanceCell.swift
//  diary
//
//  Created by 김부성 on 2021/10/07.
//

import UIKit

import ReactorKit

final class ThemeCell: BaseTableViewCell, View {
    
    typealias Reactor = ThemeReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        static let colorViewSize = 24.f
        
        // Cell
        static let cellSide = 32.f
        
        // Title
        static let titleLeft = 20.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    fileprivate struct Style {
        static let colorBorderWidth = 1.5.f
    }

    // MARK: - UI
    let colorView = UIView().then {
        $0.layer.borderWidth = Style.colorBorderWidth
        $0.layer.cornerRadius = Metric.colorViewSize / 2
    }
    let checkImage = UIImageView().then {
        $0.image = R.image.check()
    }
    
    let title = UILabel().then {
        $0.font = Font.titleFont
    }
    
    // MARK: - Initializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        
        self.addSubview(self.colorView)
        self.colorView.addSubview(self.checkImage)
        self.addSubview(self.title)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.colorView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.cellSide)
            $0.height.width.equalTo(Metric.colorViewSize)
            $0.centerY.equalToSuperview()
        }
        
        self.checkImage.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.title.snp.makeConstraints {
            $0.left.equalTo(self.colorView.snp.right)
                .offset(Metric.titleLeft)
            $0.centerY.equalToSuperview()
        }
    }

    // MARK: - Configuring
    
    func bind(reactor: ThemeReactor) {
        reactor.state.map { $0.title }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.title.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isSelected }.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.title.textColor = reactor.currentState.thridColor
                self.colorView.layer.borderColor = reactor.currentState.firstColor.cgColor
                self.colorView.backgroundColor = $0 ? reactor.currentState.secondColor : reactor.currentState.firstColor
                self.checkImage.isHidden = !$0
                self.checkImage.tintColor = reactor.currentState.firstColor
            })
            .disposed(by: disposeBag)
    }
}
