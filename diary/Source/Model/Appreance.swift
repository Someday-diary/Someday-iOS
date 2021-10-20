//
//  Appreance.swift
//  diary
//
//  Created by 김부성 on 2021/10/07.
//

import Foundation
import Then

struct AppearnceModel: Then {
    var image: UIImage
    var title: String
    var isSelected: Bool
    
    init(image: UIImage, title: String, isSelected: Bool) {
        self.image = image
        self.title = title
        self.isSelected = isSelected
    }
}
