//
//  SideMenu+Rx.swift
//  diary
//
//  Created by 김부성 on 2021/08/28.
//

import Foundation
import RxSwift
import RxCocoa
import SideMenu

final class RxSideMenuDelegateProxy: DelegateProxy<SideMenuNavigationController, SideMenuNavigationControllerDelegate>, DelegateProxyType, SideMenuNavigationControllerDelegate {
    
    static func registerKnownImplementations() {
        self.register { (sideMenu) -> RxSideMenuDelegateProxy in
            RxSideMenuDelegateProxy(parentObject: sideMenu, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: SideMenuNavigationController) -> SideMenuNavigationControllerDelegate? {
        return object.sideMenuDelegate
    }
    
    static func setCurrentDelegate(_ delegate: SideMenuNavigationControllerDelegate?, to object: SideMenuNavigationController) {
        object.sideMenuDelegate = delegate
    }
    
}

extension Reactive where Base: SideMenuNavigationController {
    public var delegate: DelegateProxy<SideMenuNavigationController, SideMenuNavigationControllerDelegate> {
        return RxSideMenuDelegateProxy.proxy(for: self.base)
    }
    
    var sideMenuWillAppear: Observable<Bool> {
        return delegate.methodInvoked(#selector(SideMenuNavigationControllerDelegate.sideMenuWillAppear(menu:animated:)))
            .map { _ in true }
    }
}
