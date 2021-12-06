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
    case getDiaryMonth(String, String)
    case getDiaryDate(String, String, String)
    // auth plugin need
    case logout
}

extension DiaryAPI: BaseAPI {
    
    var path: String {
        switch self {
        case .writeDiary, .getDiaryTag:
            return "/diary/"
        case let .updateDiary(diary):
            return "/diary/\(diary.id)"
        case .getDiaryMonth:
            return "/diary/month"
        case .getDiaryDate:
            return "/diary/date"
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
        case .getDiaryTag, .getDiaryPostID, .getDiaryMonth, .getDiaryDate:
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
                tags.append(["tag" : $0.trimmingCharacters(in: ["#"])])
            }
            return [
                "tags" : tags,
                "contents" : diary.data,
                "date" : diary.date,
                "id" : diary.id
            ]
            
        case let .updateDiary(diary):
            var tags: [[String : String]] = []
            diary.tags.components(separatedBy: " ").forEach {
                tags.append(["tag" : $0.trimmingCharacters(in: ["#"])])
            }
            return [
                "tags" : tags,
                "contents" : diary.data,
            ]
            
        case let .getDiaryTag(item):
            return [
                "tags" : item
            ]
            
        case let .getDiaryMonth(year, month):
            return [
                "year" : year,
                "month" : month
            ]
            
        case let .getDiaryDate(year, month, day):
            return [
                "year" : year,
                "month" : month,
                "day" : day
            ]
            
        default:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        switch self {
        case .getDiaryTag, .getDiaryPostID, .getDiaryMonth, .getDiaryDate:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            }
        default:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
        }
        return .requestPlain
    }
    
    var validationType: ValidationType {
        return .none
    }
    
}
