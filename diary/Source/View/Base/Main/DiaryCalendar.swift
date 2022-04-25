//
//  CalendarView.swift
//  diary
//
//  Created by 김부성 on 2021/08/24.
//

import UIKit
import RxSwift
import RxCocoa
import FSCalendar

final class DiaryCalendar: UIView {
    
    // MARK: - Properties
    private var currentPage: Date?
    let disposeBag = DisposeBag()
    
    // MARK: - Constants
    fileprivate struct Metric {
        // Button
        static let buttonTop = 18.f
        
        //Asset
        static let assetTop = 35.f
        static let assetX = 30.f
    }
    
    fileprivate struct Font {
        static let calendarTitle = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    // MARK: - UI
    let calendar = FSCalendar().then {
        $0.scrollDirection = .horizontal
        $0.today = nil
        $0.select(Date())
        $0.appearance.headerMinimumDissolvedAlpha = 0
        $0.appearance.theme.selectionColor = themeService.attribute { $0.mainColor }
        $0.appearance.titleSelectionColor = .white
        $0.appearance.headerTitleColor = R.color.calendarHeaderColor()
        $0.appearance.headerTitleFont = Font.calendarTitle
        $0.appearance.headerDateFormat = "MMM"
        $0.appearance.headerTitleOffset = CGPoint(x: 0, y: -15)
        $0.headerHeight = 80
        $0.appearance.weekdayTextColor = R.color.weekdayTextColor()
        $0.appearance.titleDefaultColor = R.color.calendarTitleDefaultColor()
        $0.appearance.titlePlaceholderColor = R.color.calendarTitlePlaceHolderColor()
        $0.appearance.subtitleFont = UIFont.systemFont(ofSize: 0)
    }
    let prevButton = UIButton().then {
        $0.setImage(R.image.calendarBackButton(), for: .normal)
        $0.tintColor = R.color.systemBlackColor()
    }
    let nextButton = UIButton().then {
        $0.setImage(R.image.calendarFrontButton(), for: .normal)
        $0.tintColor = R.color.systemBlackColor()
    }
    let calendarAsset = UIImageView().then {
        $0.image = R.image.calendarAsset()
        $0.theme.tintColor = themeService.attribute { $0.mainColor }
    }
    
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.calendar)
        self.addSubview(self.prevButton)
        self.addSubview(self.nextButton)
        self.addSubview(self.calendarAsset)
        
        self.calendar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.prevButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Metric.buttonTop)
            $0.width.equalTo(calendar.snp.width).dividedBy(7)
            $0.left.equalToSuperview()
        }
        self.nextButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Metric.buttonTop)
            $0.width.equalTo(calendar.snp.width).dividedBy(7)
            $0.right.equalToSuperview()
        }
        self.calendarAsset.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-Metric.assetX)
            $0.top.equalToSuperview().offset(Metric.assetTop)
        }
    }
    
    // MARK: - Configuring
    func bind() {
        self.nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveCurrentPage(moveUp: true)
            }).disposed(by: disposeBag)
        
        self.prevButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveCurrentPage(moveUp: false)
            }).disposed(by: disposeBag)
    }
    
    private func moveCurrentPage(moveUp: Bool) {
        let newPage = Calendar.current.date(byAdding: .month, value: moveUp ? 1 : -1, to: self.calendar.currentPage)!
        self.calendar.setCurrentPage(newPage, animated: true)
    }
    
}
