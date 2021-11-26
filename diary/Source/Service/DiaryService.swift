//
//  DiaryService.swift
//  diary
//
//  Created by 김부성 on 2021/11/02.
//

import Foundation

import RxSwift

protocol DiaryServiceType: AnyObject {
    func createDiary(_ diary: Diary) -> Single<NetworkResult>
    func updateDiary(_ diary: Diary) -> Single<NetworkResult>
    func deleteDiary(_ postID: String) -> Single<NetworkResult>
    func getMonthDiary(_ year: String, _ month: String) -> Single<NetworkResultWithValue<ListResponse>>
    func getDayDiary(_ year: String, _ month: String, _ day: String) -> Single<NetworkResultWithValue<DiaryResponse>>
    func getDiaryPostID(_ postID: String) -> Single<NetworkResultWithValue<DiaryResponse>>
    func getDiaryTag(_ tag: String) -> Single<NetworkResultWithValue<DiaryListResponse>>
}
          
class DiaryService: DiaryServiceType {
    
    fileprivate let network: Network<DiaryAPI>
    
    init(network: Network<DiaryAPI>) {
        self.network = network
    }
    
    func createDiary(_ diary: Diary) -> Single<NetworkResult> {
        return network.requestObject(.writeDiary(diary), type: CreateResponse.self)
            .map { result in
                switch result {
                case .success(_):
                    return .success
                case let .error(error):
                    return .error(error)
                }
            }
    }
    
    func updateDiary(_ diary: Diary) -> Single<NetworkResult> {
        return network.requestObject(.updateDiary(diary), type: ServerResponse.self)
            .map { result in
                switch result {
                case .success(_):
                    return .success
                case let .error(error):
                    return .error(error)
                }
            }
    }
    
    func deleteDiary(_ postID: String) -> Single<NetworkResult> {
        return network.requestObject(.deleteDiary(postID), type: ServerResponse.self)
            .map { result in
                switch result {
                case .success(_):
                    return .success
                case let .error(error):
                    return .error(error)
                }
            }
    }
    
    func getMonthDiary(_ year: String, _ month: String) -> Single<NetworkResultWithValue<ListResponse>> {
        return network.requestObject(.getDiaryMonth(year, month), type: ListResponse.self)
    }
    
    func getDayDiary(_ year: String, _ month: String, _ day: String) -> Single<NetworkResultWithValue<DiaryResponse>> {
        return network.requestObject(.getDiaryDate(year, month, day), type: DiaryResponse.self)
    }
    
    func getDiaryPostID(_ postID: String) -> Single<NetworkResultWithValue<DiaryResponse>> {
        return network.requestObject(.getDiaryPostID(postID), type: DiaryResponse.self)
    }
    
    func getDiaryTag(_ tag: String) -> Single<NetworkResultWithValue<DiaryListResponse>> {
        return network.requestObject(.getDiaryTag(tag), type: DiaryListResponse.self)
    }
    
}
