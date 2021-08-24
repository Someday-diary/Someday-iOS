//
//  Preview.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

//struct ViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//        let reactor = MainViewReactor()
//        MainViewController(reactor: reactor).showPreview(.iPhone12Pro)
//    }
//}

struct ViewPreview: PreviewProvider {
    static var previews: some View {
        DiaryCalendar().showPreview(width: 300, height: 300)
    }
}

#endif
