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
            return NetworkErrorMsg.unknownMsg.rawValue
        case .noConnection:
            return NetworkErrorMsg.noConnectionMsg.rawValue
        case .typeError:
            return NetworkErrorMsg.typeErrorMsg.rawValue
        case .requestError:
            return NetworkErrorMsg.requestErrorMsg.rawValue
        case .unauthorized:
            return NetworkErrorMsg.unauthorizedMsg.rawValue
        case .serverError:
            return NetworkErrorMsg.serverErrorMsg.rawValue
        case .signInExist:
            return NetworkErrorMsg.SignInExistMsg.rawValue
        case .noEmailCode:
            return NetworkErrorMsg.noEmailCodeMsg.rawValue
        case .canNotVerify:
            return NetworkErrorMsg.canNotVerifyMsg.rawValue
        case .noRegisterEmail:
            return NetworkErrorMsg.noRegisterEmailMsg.rawValue
        case .accountExist:
            return NetworkErrorMsg.accountExistMsg.rawValue
        case .noUesr:
            return NetworkErrorMsg.noUserMsg.rawValue
        case .noLoginEmail:
            return NetworkErrorMsg.noLoginEmailMsg.rawValue
        case .passwordNotCorrect:
            return NetworkErrorMsg.passwordNotCorrectMsg.rawValue
        case .alreadyLogout:
            return NetworkErrorMsg.alreadyLogoutMsg.rawValue
        case .timeNotCorrect:
            return NetworkErrorMsg.timeNotCorrectMsg.rawValue
        case .noDiary:
            return NetworkErrorMsg.noDiaryMsg.rawValue
        case .notMyDiary:
            return NetworkErrorMsg.notMyDiaryMsg.rawValue
        }
    }
}

enum NetworkErrorMsg: String {
    case unknownMsg = "서버와의 통신중 에러가 발생했습니다."
    case noConnectionMsg = "인터넷 연결 실패"
    case typeErrorMsg = "값 변환 오류. 개발자에게 문의해주세요"
    case requestErrorMsg = "리퀘스트 형식이 맞지 않습니다"
    case unauthorizedMsg = "토큰 에러, 다시 로그인 해주세요."
    case serverErrorMsg = "서버 에러"
    
    case SignInExistMsg = "이미 가입되어있는 유저입니다."
    
    case noEmailCodeMsg = "다시 이메일 인증요청을 보내주세요"
    case canNotVerifyMsg = "코드가 맞지 않습니다."
    
    case noRegisterEmailMsg = "이메일 인증이 완료되지 않았습니다."
    case accountExistMsg = "사용중인 이메일입니다."
    
    case noUserMsg = "일치하는 유저가 없습니다."
    case noLoginEmailMsg = "로그인 이메일 인증이 완료되지 않았습니다."
    case passwordNotCorrectMsg = "비밀번호를 다시 확인해주세요."
    
    case alreadyLogoutMsg = "이미 로그아웃 상태입니다."
    
    case timeNotCorrectMsg = "시간형식이 맞지 않습니다."
    
    case noDiaryMsg = "일치하는 일기가 없습니다."
    case notMyDiaryMsg = "본인의 일기가 아닙니다."
}
