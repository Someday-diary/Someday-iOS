//
//  UITextField.swift
//  diary
//
//  Created by 김부성 on 2021/09/06.
//

import UIKit

public extension UITextField {
    
    var clearButton : UIButton {
        return self.value(forKey: "_clearButton") as! UIButton
    }
    
    var clearButtonTintColor: UIColor? {
        get {
            return clearButton.tintColor
        }
        set {
            var image = clearButton.imageView?.image
            
            if image == nil{
                image = UIImage(named: "clear_field")
            }
            
            image =  image?.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(image, for: .normal)
            clearButton.tintColor = newValue
        }
    }
    
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
