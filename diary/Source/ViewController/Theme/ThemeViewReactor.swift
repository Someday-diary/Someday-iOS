//
//  ThemeViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/10/06.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow

final class ThemeViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        case refresh
        case selected(IndexPath)
    }
    
    enum Mutation {
        case refreshCells([UIImage], [String])
        case updateAppearance(Int)
    }
    
    struct State {
        let sectionHeaderTitles: [String] = ["라이트 / 다크", "테마 색상 설정"]
        let appearanceTitles: [String] = ["시스템 설정 모드", "라이트 모드", "다크 모드"]
        let appearanceImages: [UIImage] = [R.image.systemMode()!, R.image.lightMode()!, R.image.darkMode()!]
        
        // State
        var appearanceSelected: Int
        
        var appearanceSectionItems: [ThemeViewSectionItem] = []
        var sections: [ThemeViewSection] {
            let section: [ThemeViewSection] = [
                .appearance(self.appearanceSectionItems)
            ]
            return section
        }
    }
    
    init() {
        self.initialState = State(appearanceSelected: UserDefaults.standard.integer(forKey: "Appearance"))
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return Observable.just(Mutation.refreshCells(currentState.appearanceImages, currentState.appearanceTitles))
            
        case let .selected(indexPath):
            switch indexPath.section {
            case 0:
                return Observable.concat([
                    Observable.just(Mutation.updateAppearance(indexPath.row)),
                    Observable.just(Mutation.refreshCells(currentState.appearanceImages, currentState.appearanceTitles))
                ])
            default:
                return Observable.empty()
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .refreshCells(image, title):
            state.appearanceSectionItems.removeAll()
            
            for idx in 0..<title.count {
                state.appearanceSectionItems.append(
                    .appearance(AppearanceReactor(model: AppearnceModel(image: image[idx], title: title[idx], isSelected: idx == self.currentState.appearanceSelected)))
                )
            }
            
        case let .updateAppearance(idx):
            state.appearanceSelected = idx
            UserDefaults.standard.set(idx, forKey: "Appearance")
        }
        
        return state
    }
}
