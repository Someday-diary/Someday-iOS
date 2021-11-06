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
    
    init(plugins: [PluginType] = []) {
        let session = MoyaProvider<API>.defaultAlamofireSession()
        // set Timeout
        session.sessionConfiguration.timeoutIntervalForRequest = 10
        
        super.init(session: session, plugins: plugins)
    }
    
    func request(_ api: API) -> Single<Response> {
        return self.rx.request(api)
            .filter(statusCodes: 200...400)
    }
}

extension Network {
    func requestObject<T: ModelType>(_ target: API, type: T.Type) -> Single<NetworkResultWithValue<T>> {
        let decoder = type.decoder
        return request(target)
            .map(T.self, using: decoder)
            .map { result in
                guard let error = NetworkError(rawValue: result.code) else { return .success(result) }
                return .error(error)
            }.catchErrorJustReturn(.error(.unknown))
    }

}
