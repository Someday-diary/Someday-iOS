//
//  Preview.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        MainViewController().showPreview(.iPhone12Pro)
    }
}

#endif
