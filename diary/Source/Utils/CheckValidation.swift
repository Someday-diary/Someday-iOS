//
//  CheckValidation.swift
//  diary
//
//  Created by 김부성 on 2021/08/28.
//

import Foundation

enum CheckValidation: Equatable {
    case correct
    case empty
    case error(message: String)
}

extension String {
    var isValidEmail: CheckValidation {
        guard !self.isEmpty else { return .empty }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailcheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
        return emailcheck ? .correct : .error(message: "이메일 형식이 맞지 않습니다.")
    }
    
    var isValidPassword: CheckValidation {
        guard !self.isEmpty else { return .empty }
        return self.count >= 5 ? .correct : .error(message: "비밀번호가 4자리 이하입니다.")
    }
}
