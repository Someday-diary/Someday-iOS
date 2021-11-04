//
//  DiaryService.swift
//  diary
//
//  Created by 김부성 on 2021/11/02.
//

import Foundation

import RxSwift

protocol DiaryServiceType: AnyObject {
    func createDiary(_ diary: Diary) -> Single<Void>
    func updateDiary(_ diary: Diary) -> Single<Void>
    func deleteDiary(_ postID: String) -> Single<Void>
    func getMonthDiary(_ year: String, _ month: String) -> Single<ListResponse>
    func getDayDiary(_ year: String, _ month: String, _ day: String) -> Single<DiaryResponse>
    func getDiaryPostID(_ postID: String) -> Single<DiaryResponse>
}
          
class DiaryService: DiaryServiceType {
    
    fileprivate let network: Network<DiaryAPI>
    
    init(network: Network<DiaryAPI>) {
        self.network = network
    }
    
    func createDiary(_ diary: Diary) -> Single<Void> {
        return network.requestObject(.writeDiary(diary), type: CreateResponse.self).map { _ in }
    }
    
    func updateDiary(_ diary: Diary) -> Single<Void> {
        return network.requestObject(.updateDiary(diary), type: ServerResponse.self).map { _ in }
    }
    
    func deleteDiary(_ postID: String) -> Single<Void> {
        return network.requestObject(.deleteDiary(postID), type: ServerResponse.self).map { _ in }
    }
    
    func getMonthDiary(_ year: String, _ month: String) -> Single<ListResponse> {
        return network.requestObject(.getDiaryMonth(year, month), type: ListResponse.self)
    }
    
    func getDayDiary(_ year: String, _ month: String, _ day: String) -> Single<DiaryResponse> {
        return network.requestObject(.getDiaryDate(year, month, day), type: DiaryResponse.self)
    }
    
    func getDiaryPostID(_ postID: String) -> Single<DiaryResponse> {
        return network.requestObject(.getDiaryPostID(postID), type: DiaryResponse.self)
    }
    
}
