//
//  NetworkError.swift
//  diary
//
//  Created by 김부성 on 2021/11/05.
//

import Foundation
import RxSwift

enum NetworkError: Int, Error {
    // ALL
    case unknown = 0
    case noConnection = 1
    case typeError = 2
    case requestError = 400
    case unauthorized = 401
    case serverError = 500
    
    // Request Email
    case signInExist = 101
    
    // Verify Email
    case noEmailCode = 102
    case canNotVerify = 103
    
    // Register
    case noRegisterEmail = 104
    case accountExist = 105
    
    // Login
    case noUesr = 106
    case noLoginEmail = 107
    case passwordNotCorrect = 108
    
    // Logout
    case alreadyLogout = 112
    
    // Create
    case timeNotCorrect = 109
    
    // Get, Delete
    case noDiary = 110
    case notMyDiary = 111
    
    var message: String {
        switch self {
        case .unknown:
            return NetworkErrorMsg.unknownMsg.localizedMsg
        case .noConnection:
            return NetworkErrorMsg.noConnectionMsg.localizedMsg
        case .typeError:
            return NetworkErrorMsg.typeErrorMsg.localizedMsg
        case .requestError:
            return NetworkErrorMsg.requestErrorMsg.localizedMsg
        case .unauthorized:
            return NetworkErrorMsg.unauthorizedMsg.localizedMsg
        case .serverError:
            return NetworkErrorMsg.serverErrorMsg.localizedMsg
        case .signInExist:
            return NetworkErrorMsg.SignInExistMsg.localizedMsg
        case .noEmailCode:
            return NetworkErrorMsg.noEmailCodeMsg.localizedMsg
        case .canNotVerify:
            return NetworkErrorMsg.canNotVerifyMsg.localizedMsg
        case .noRegisterEmail:
            return NetworkErrorMsg.noRegisterEmailMsg.localizedMsg
        case .accountExist:
            return NetworkErrorMsg.accountExistMsg.localizedMsg
        case .noUesr:
            return NetworkErrorMsg.noUserMsg.localizedMsg
        case .noLoginEmail:
            return NetworkErrorMsg.noLoginEmailMsg.localizedMsg
        case .passwordNotCorrect:
            return NetworkErrorMsg.passwordNotCorrectMsg.localizedMsg
        case .alreadyLogout:
            return NetworkErrorMsg.alreadyLogoutMsg.localizedMsg
        case .timeNotCorrect:
            return NetworkErrorMsg.timeNotCorrectMsg.localizedMsg
        case .noDiary:
            return NetworkErrorMsg.noDiaryMsg.localizedMsg
        case .notMyDiary:
            return NetworkErrorMsg.notMyDiaryMsg.localizedMsg
        }
    }
    
}

enum NetworkErrorMsg: String {
    case unknownMsg = "Unkwon Error. Please Contect Us"
    case noConnectionMsg = "No Internet Connection"
    case typeErrorMsg = "Type Casting Error. Please Contect Us"
    case requestErrorMsg = "Request Error. Please Contect Us"
    case unauthorizedMsg = "Token Error. Please sign in again"
    case serverErrorMsg = "Server Error. Please Contect Us"
    
    case SignInExistMsg = "Already Exist Account"
    
    case noEmailCodeMsg = "Please resend email verify code"
    case canNotVerifyMsg = "Verify code is not match"
    
    case noRegisterEmailMsg, noLoginEmailMsg = "Email verification not confirmed yet"
    case accountExistMsg = "This email is already in use"
    
    case noUserMsg = "Matched user not exist"
    case passwordNotCorrectMsg = "Wrong password. Try again"
    
    case alreadyLogoutMsg = "Already signed out"
    
    case timeNotCorrectMsg = "Time format Error. Please Contect Us"
    
    case noDiaryMsg = "There is not matched Diary"
    case notMyDiaryMsg = "This is not your diary"
    
    var localizedMsg: String {
        return self.rawValue.localized
    }
}
