//
//  MainViewController.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//

import UIKit
import ReactorKit
import FSCalendar

class MainViewController: BaseViewController, View {
    
    typealias Reactor = MainViewReactor
    
    struct Font {
        static let calendarTitle = UIFont.systemFont(ofSize: 24)
    }
    
    let calendar = FSCalendar().then {
        $0.scrollDirection = .horizontal
        $0.today = nil
        $0.appearance.headerMinimumDissolvedAlpha = 0
        $0.select(Date())
        $0.appearance.selectionColor = R.color.appColor()
        $0.appearance.titleSelectionColor = .white
        $0.appearance.headerTitleColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        $0.appearance.headerTitleFont = Font.calendarTitle
        $0.appearance.weekdayTextColor = #colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.5764705882, alpha: 1)
    }
    let label = UILabel()
    
    init(reactor: Reactor) {
        super.init()
        defer { self.reactor = reactor }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupLayout() {
        self.view.addSubview(calendar)
        self.view.addSubview(label)
    }
    
    override func makeConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.calendar.snp.makeConstraints {
            $0.bottom.equalTo(safeArea.snp.centerY)
            $0.top.equalTo(safeArea.snp.top)
            $0.left.equalTo(safeArea.snp.left)
            $0.right.equalTo(safeArea.snp.right)
        }
    }
    
    func bind(reactor: MainViewReactor) {
        // MARK: input
        calendar.rx.didSelect.asObservable()
            .map { Reactor.Action.setDay($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        // MARK: output
        reactor.state
            .map { "\($0.selectedDay)" }
            .distinctUntilChanged()
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }

}
