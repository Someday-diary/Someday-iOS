//
//  AppearanceCell.swift
//  diary
//
//  Created by 김부성 on 2021/10/07.
//

import UIKit

import ReactorKit

final class AppearanceCell: BaseTableViewCell, View {
    
    typealias Reactor = AppearanceReactor
    
    // MARK: Constants
    fileprivate struct Metric {
        // Image
        static let imageWidth = 44.f
        static let iamgeHeight = 70.f
        
        // Title
        static let titleLeft = 16.f
        
        // Button
        static let buttonSize = 16.f
        
        // Cell
        static let cellSide = 32.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    fileprivate struct Style {
        // Image
        static let imageCornerRadius = 5.f
        static let imageBorderWidth = 1.5.f
    }

    // MARK: - UI
    let image = UIImageView().then {
        $0.layer.cornerRadius = Style.imageCornerRadius
        $0.layer.theme.borderColor = themed { $0.thirdColor.cgColor }
    }
    
    let title = UILabel().then {
        $0.font = Font.titleFont
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let button = UIButton().then {
        $0.setImage(R.image.selectedButton(), for: .selected)
        $0.setImage(R.image.unSelectedButton(), for: .normal)
        $0.theme.tintColor = themed { $0.thirdColor }
    }
    
    // MARK: - Initializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        
        self.addSubview(self.image)
        self.addSubview(self.title)
        self.addSubview(self.button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.image.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.cellSide)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(Metric.iamgeHeight)
            $0.width.equalTo(Metric.imageWidth)
        }
        
        self.title.snp.makeConstraints {
            $0.left.equalTo(self.image.snp.right).offset(Metric.titleLeft)
            $0.right.equalTo(self.button.snp.left)
            $0.centerY.equalToSuperview()
        }
        
        self.button.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-Metric.cellSide)
            $0.width.height.equalTo(Metric.buttonSize)
            $0.centerY.equalToSuperview()
        }
    }

    // MARK: - Configuring
    
    func bind(reactor: AppearanceReactor) {
        reactor.state.map { $0.title }.asObservable()
            .bind(to: self.title.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.image }.asObservable()
            .bind(to: self.image.rx.image)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isSelected }.asObservable()
            .bind(to: self.button.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isSelected }.asObservable()
            .subscribe(onNext: { [weak self] selected in
                guard let self = self else { return }
                self.title.theme.textColor = themed { selected ? $0.thirdColor : $0.tableViewCellColor }
                self.image.layer.borderWidth = selected ? Style.imageBorderWidth : 0
            })
            .disposed(by: disposeBag)
    }
}
