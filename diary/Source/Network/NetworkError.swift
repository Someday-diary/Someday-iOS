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
}
