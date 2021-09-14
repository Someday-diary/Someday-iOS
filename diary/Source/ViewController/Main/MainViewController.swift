//
//  MainViewController.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//

import UIKit

import ReactorKit
import FSCalendar

final class MainViewController: BaseViewController, View {
    
    // MARK: - Properties
    typealias Reactor = MainViewReactor
    
    // MARK: - Constants
    
    fileprivate struct Metric {
        // Calendar
        static let calendarSide = 26.f
        static let calendarBottom = 13.f
        
        // BarButtonPadding
        static let navigativePadding = 18.f
        
        // Separator
        static let separatorHeight = 1.f
        
        // ImageView
        static let imageHeight = 170.f
        static let imageWidth = 180.f
        static let imageRight = 25.f
        
        // WriteButton
        static let writeButtonTop = 30.f
        static let writeButtonSide = 32.f
    }
    
    fileprivate struct Font {
        static let calendarTitle = UIFont.systemFont(ofSize: 24)
    }
    
    // MARK: - UI
    
    let navigativePadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil).then {
        $0.width = Metric.navigativePadding
    }
    
    let sideMenuButton = UIBarButtonItem(image: R.image.diarySideMenuButton(), style: .done, target: nil, action: nil).then {
        $0.tintColor = R.color.navigationButtonColor()
    }
    
    let calendarView = DiaryCalendar()
    
    let separatorView = UIView().then {
        $0.backgroundColor = R.color.textFieldSeparatorColor()
    }
    
    // MARK: - Initializing
    init(reactor: Reactor) {
        super.init()
        defer { self.reactor = reactor }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.navigationItem.leftBarButtonItems = [navigativePadding, sideMenuButton]
        self.view.addSubview(self.calendarView)
        self.view.addSubview(self.separatorView)
    }
    
    override func setupConstraints() {
        
        self.calendarView.snp.makeConstraints {
            $0.bottom.equalTo(self.separatorView.snp.top).offset(-Metric.calendarBottom)
            $0.top.equalToSafeArea(self.view)
            $0.left.equalToSafeArea(self.view).offset(Metric.calendarSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.calendarSide)
        }
        
        self.separatorView.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view)
            $0.right.equalToSafeArea(self.view)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.centerY)
            $0.height.equalTo(Metric.separatorHeight)
        }
        
    }
    
    // MARK: - Configuring
    
    func bind(reactor: MainViewReactor) {
        // Input
        self.rx.viewDidAppear.asObservable()
            .map { _ in Reactor.Action.presentFloatingPanel }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.rx.viewDidAppear.asObservable()
            .map { [weak self] _ in
                return Reactor.Action.changeMonth((self?.calendarView.calendar.currentPage.changeTime)!)
            }
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.calendarView.calendar.rx.didSelect.asObservable()
            .distinctUntilChanged()
            .map { Reactor.Action.changeDay($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.calendarView.calendar.rx.calendarCurrentPageDidChange.asObservable()
            .map { Reactor.Action.changeMonth($0.currentPage.changeTime) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.sideMenuButton.rx.tap.asObservable()
            .map { Reactor.Action.presentSideMenu }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    
        
        Observable.combineLatest(
            themed { $0.mainColor },
            themed { $0.subColor },
            themed { $0.thirdColor }
        ).asObservable()
        .observeOn(MainScheduler.asyncInstance)
        .map { Reactor.Action.changeColor([$0, $1, $2]) }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        // Output
        reactor.state.map { $0.themeColor }.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.calendarView.calendar.reloadData()
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.writedDays }.asObservable()
            .distinctUntilChanged()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                self?.calendarView.calendar.reloadData()
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.month }.asObservable()
            .distinctUntilChanged()
            .map { ($0).titleString }
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
        
        // View
        self.calendarView.calendar.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

}

// MARK: - Delegate

extension MainViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        guard let reactor = reactor else { return nil }
        if reactor.currentState.writedDays.contains(date) { return reactor.currentState.themeColor?[0] ?? nil }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {

        guard let reactor = reactor else { return nil }
        if reactor.currentState.writedDays.contains(date) { return reactor.currentState.themeColor?[1] ?? nil }
        return nil
    }
    
}
