//
//  CheckValidation.swift
//  diary
//
//  Created by 김부성 on 2021/08/28.
//

import Foundation

enum CheckValidation: Equatable {
    case correct( _ type: validationType)
    case empty
    case error(_ message: String)
}

enum validationType: String, Equatable {
    case email = "이메일"
    case password = "비밀번호"
    
    
}

extension String {
    var isValidEmail: CheckValidation {
        guard !self.isEmpty else { return .empty }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailcheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
        return emailcheck ? .correct(.email) : .error("이메일 형식이 맞지 않습니다.")
    }
    
    var isValidPassword: CheckValidation {
        guard !self.isEmpty else { return .empty }
        return self.count >= 4 ? .correct(.password) : .error("비밀번호를 4자리 이상 입력해주세요.")
    }
}
