//
//  DiaryAPI.swift
//  diary
//
//  Created by 김부성 on 2021/11/03.
//

import Foundation

import Moya

enum DiaryAPI {
    case writeDiary(Diary)
    case getDiaryTag(String)
    case getDiaryPostID(String)
    case updateDiary(Diary)
    case deleteDiary(String)
    case getDiaryDate(String, String)
    // auth plugin need
    case logout
}

extension DiaryAPI: BaseAPI {
    
    var path: String {
        switch self {
        case .writeDiary, .getDiaryTag, .updateDiary, .getDiaryDate:
            return "/diary"
        case let .deleteDiary(postID):
            return "/diary/\(postID)"
        case let .getDiaryPostID(postID):
            return "/diary/\(postID)"
        case .logout:
            return "/user/logout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .writeDiary:
            return .post
        case .getDiaryTag, .getDiaryPostID, .getDiaryDate:
            return .get
        case .updateDiary:
            return .patch
        case .deleteDiary, .logout:
            return .delete
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .writeDiary(diary):
            var tags: [[String : String]] = []
            diary.tags.components(separatedBy: " ").forEach {
                tags.append(["tag" : $0])
            }
            return [
                "tag" : tags,
                "contents" : diary.data,
                "date" : diary.date,
                "id" : UUID().uuidString
            ]
            
        case let .getDiaryTag(item):
            return [
                "tag" : item
            ]
            
        case let .getDiaryDate(year, month):
            return [
                "year" : year,
                "month" : month
            ]
            
        default:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}
