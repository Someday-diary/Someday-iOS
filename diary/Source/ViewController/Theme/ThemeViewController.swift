//
//  ThemeViewController.swift
//  diary
//
//  Created by 김부성 on 2021/10/06.
//

import UIKit

import ReusableKit
import RxDataSources
import ReactorKit

final class ThemeViewController: BaseViewController, View {
    
    typealias Reactor = ThemeViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        
    }
    
    fileprivate struct Font {
        
    }
    
    fileprivate struct Reusable {
        static let sectionHeaderView = ReusableView<ThemeSectionHeaderView>()
        static let appearanceCell = ReusableCell<AppearanceCell>()
        static let themeCell = ReusableCell<ThemeCell>()
    }
    
    // MARK: - Properties
    fileprivate let dataSource: RxTableViewSectionedReloadDataSource<ThemeViewSection>
    
    // MARK: - UI
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.register(Reusable.sectionHeaderView)
        $0.register(Reusable.appearanceCell)
        $0.register(Reusable.themeCell)
    }
    
    // MARK: - Inintializing
    init(reactor: Reactor) {
        self.dataSource = Self.dataSourceFactory()
        super.init()
        
        defer { self.reactor = reactor }
        self.title = "Theme Setting".localized
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<ThemeViewSection> {
        return .init(configureCell: { dataSource, tableView, indexPath, sectionItem in
            switch sectionItem {
            case let .appearance(reactor):
                let cell = tableView.dequeue(Reusable.appearanceCell, for: indexPath)
                cell.reactor = reactor
                return cell
                
            case let .theme(reactor):
                let cell = tableView.dequeue(Reusable.themeCell, for: indexPath)
                cell.reactor = reactor
                return cell
            }
        })
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(self.tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSafeArea(self.view)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: ThemeViewReactor) {
        // Input
        self.rx.viewDidAppear.asObservable()
            .map { _ in Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected.asObservable()
            .map { Reactor.Action.selected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        reactor.state.map { $0.sections }
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        // View
        self.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: { [weak tableView] indexPath in
                tableView?.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension ThemeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionItem = self.dataSource[indexPath]
        
        switch sectionItem {
        case .appearance:
            return 90
            
        case .theme:
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeue(Reusable.sectionHeaderView)
        view?.title.text = self.reactor?.currentState.sectionHeaderTitles[section]
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
}
