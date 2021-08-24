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
    
    private var currentPage: Date?
    let disposeBag = DisposeBag()
    
    // MARK: Constants
    fileprivate struct Font {
        static let calendarTitle = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    // MARK: UI
    let calendar = FSCalendar().then {
        $0.scrollDirection = .horizontal
        $0.today = nil
        $0.select(Date())
        $0.appearance.headerMinimumDissolvedAlpha = 0
        $0.appearance.selectionColor = R.color.mainColor()
        $0.appearance.titleSelectionColor = .systemBackground
        $0.appearance.headerTitleColor = R.color.calendarHeaderColor()
        $0.appearance.headerTitleFont = Font.calendarTitle
        $0.appearance.headerDateFormat = "MMM"
        $0.headerHeight = 80
        $0.appearance.weekdayTextColor = R.color.weekdayTextColor()
        $0.appearance.titleDefaultColor = R.color.calendarTitleDefaultColor()
        $0.appearance.titlePlaceholderColor = R.color.calendarTitlePlaceHolderColor()
        $0.appearance.eventDefaultColor = R.color.mainColor()
        $0.appearance.eventSelectionColor = R.color.mainColor()
        $0.appearance.subtitleFont = UIFont.systemFont(ofSize: 0)
        $0.locale = Locale(identifier: "ko_KR")
    }
    let prevButton = UIButton().then {
        $0.setImage(R.image.calendarBackButton(), for: .normal)
    }
    let nextButton = UIButton().then {
        $0.setImage(R.image.calendarFrontButton(), for: .normal)
    }
    let calendarAsset = UIImageView().then {
        $0.image = R.image.calendarAsset()
    }
    
    // MARK: Initializing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            $0.top.equalToSuperview().offset(33)
            $0.width.equalTo(calendar.snp.width).dividedBy(7)
            $0.left.equalToSuperview().offset(0)
        }
        self.nextButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(33)
            $0.width.equalTo(calendar.snp.width).dividedBy(7)
            $0.right.equalToSuperview().offset(0)
        }
        self.calendarAsset.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(50)
        }
    }
    
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
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? Date())
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
}
