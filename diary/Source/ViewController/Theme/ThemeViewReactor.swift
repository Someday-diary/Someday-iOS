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
        case refreshCells([UIImage], [String], [String], [[UIColor]])
        case updateAppearance(Int)
        case updateTheme(Int)
    }
    
    struct State {
        // Header
        let sectionHeaderTitles: [String] = ["라이트 / 다크", "테마 색상 설정"]
        
        // Appearance
        let appearanceTitles: [String] = ["시스템 설정 모드", "라이트 모드", "다크 모드"]
        let appearanceImages: [UIImage] = [R.image.systemMode()!, R.image.lightMode()!, R.image.darkMode()!]
        
        // Theme
        let themeTitles: [String] = ["민트초코", "블루레몬에이드"]
        let themeColorList: [[UIColor]] = [[R.color.greenThemeMainColor()!, R.color.greenThemeSubColor()!, R.color.greenThemeThirdColor()!], [R.color.blueThemeMainColor()!, R.color.blueThemeSubColor()!, R.color.blueThemeThirdColor()!]]
        
        // State
        var appearanceSelected: Int
        var themeSelected: Int
        
        var appearanceSectionItems: [ThemeViewSectionItem] = []
        var themeSectionItems: [ThemeViewSectionItem] = []
        var sections: [ThemeViewSection] {
            let section: [ThemeViewSection] = [
                .appearance(self.appearanceSectionItems),
                .theme(self.themeSectionItems)
            ]
            return section
        }
    }
    
    init() {
        self.initialState = State(
            appearanceSelected: UserDefaults.standard.integer(forKey: "Appearance"),
            themeSelected: UserDefaults.standard.integer(forKey: "Theme")
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return Observable.just(Mutation.refreshCells(currentState.appearanceImages, currentState.appearanceTitles, currentState.themeTitles, currentState.themeColorList))
            
        case let .selected(indexPath):
            switch indexPath.section {
            case 0:
                self.changeAppearance(idx: indexPath.row)
                
                return Observable.concat([
                    Observable.just(Mutation.updateAppearance(indexPath.row)),
                    Observable.just(Mutation.refreshCells(currentState.appearanceImages, currentState.appearanceTitles, currentState.themeTitles, currentState.themeColorList))
                ])
                
            case 1:
                self.changeTheme(idx: indexPath.row)
                
                return Observable.concat([
                    Observable.just(Mutation.updateTheme(indexPath.row)),
                    Observable.just(Mutation.refreshCells(currentState.appearanceImages, currentState.appearanceTitles, currentState.themeTitles, currentState.themeColorList))
                ])
                
            default:
                return Observable.empty()
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .refreshCells(appearanceImage, appearanceTitle, themeTitle, themeColors):
            state.appearanceSectionItems.removeAll()
            state.themeSectionItems.removeAll()
            
            for idx in 0..<appearanceTitle.count {
                state.appearanceSectionItems.append(
                    .appearance(AppearanceReactor(model: AppearnceModel(image: appearanceImage[idx], title: appearanceTitle[idx], isSelected: idx == self.currentState.appearanceSelected)))
                )
            }
            
            for idx in 0..<themeTitle.count {
                state.themeSectionItems.append(
                    .theme(ThemeReactor(model: ThemeModel(firstColor: themeColors[idx][0], secondColor: themeColors[idx][1], thirdColor: themeColors[idx][2], title: themeTitle[idx], isSelected: idx == self.currentState.themeSelected)))
                )
            }
            
        case let .updateAppearance(idx):
            state.appearanceSelected = idx
            UserDefaults.standard.set(idx, forKey: "Appearance")
            
        case let .updateTheme(idx):
            state.themeSelected = idx
            UserDefaults.standard.set(idx, forKey: "Theme")
        }
        
        return state
    }
}

extension ThemeViewReactor {
    private func changeAppearance(idx: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        switch idx {
            
        case 0:
            appDelegate.changeTheme(themeVal: "system")
            
        case 1:
            appDelegate.changeTheme(themeVal: "light")
            
        case 2:
            appDelegate.changeTheme(themeVal: "dark")
            
        default:
            break
        }
    }
    
    private func changeTheme(idx: Int) {
        switch idx {
            
        case 0:
            themeService.switch(ThemeType.green)
            
        case 1:
            themeService.switch(ThemeType.blue)
            
        default:
            break
        }
    }
}
