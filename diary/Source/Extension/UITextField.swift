//
//  UITextField.swift
//  diary
//
//  Created by 김부성 on 2021/09/06.
//

import UIKit

public extension UITextField {
    
    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
    
}
