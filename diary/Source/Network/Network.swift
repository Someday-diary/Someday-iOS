//
//  Network.swift
//  diary
//
//  Created by 김부성 on 2021/10/30.
//

import Foundation

import RxSwift
import Moya

class Network<API: TargetType>: MoyaProvider<API> {
    
    init() {
        let session = MoyaProvider<API>.defaultAlamofireSession()
        // set Timeout
        session.sessionConfiguration.timeoutIntervalForRequest = 10
        
        super.init(session: session)
    }
    
    func request(_ api: API) -> Single<Response> {
        return self.rx.request(api)
            .filterSuccessfulStatusCodes()
    }
}

extension Network {
    func requestObject<T: Codable>(_ target: API, type: T.Type) -> Single<T> {
        let decoder = JSONDecoder()
        return request(target)
            .map(T.self, using: decoder)
    }
    
    func requestArray<T: Codable>(_ target: API, tpye: T.Type) -> Single<[T]> {
        let decoder = JSONDecoder()
        return request(target)
            .map([T].self, using: decoder)
    }
}
