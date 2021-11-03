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
//    func getMonthDiary(_ year: String, _ month: String) -> Single<
}
          
class DiaryService: DiaryServiceType {
    
    fileprivate let network: Network<DiaryAPI>
    
    init(network: Network<DiaryAPI>) {
        self.network = network
    }
    
    func createDiary(_ diary: Diary) -> Single<Void> {
        return network.requestObject(.writeDiary(diary), type: CreateResponse.self).map { _ in }
    }
    
    
}
