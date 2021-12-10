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
    case email = "Email"
    case password = "Password"
    case code = "Verification Code"
    case reEnter = "Confirm password"
}

extension String {
    var isValidEmail: CheckValidation {
        guard !self.isEmpty else { return .empty }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailcheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
        return emailcheck ? .correct(.email) : .error("It is not email format".localized)
    }
    
    var isValidPassword: CheckValidation {
        guard !self.isEmpty else { return .empty }
        return self.count >= 4 ? .correct(.password) : .error("Enter password at least 4".localized)
    }
    
    var isValidCode: CheckValidation {
        guard !self.isEmpty else { return .empty }
        return self.count == 6 ? .correct(.code) : .error("Validation code is 6 digits".localized)
    }
    
    var validationTagString: String {
        return self.components(separatedBy: ["#", " "]).joined()
    }
    
}

extension Array where Element == String {
    var isValidReEnter: CheckValidation {
        guard !self[1].isEmpty else { return .empty }
        
        return self[0] == self[1] ? .correct(.reEnter) : .error("Incorrect Password".localized)
    }
}
