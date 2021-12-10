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
    }
}

extension Network {
    func requestObject<T: ModelType>(_ target: API, type: T.Type) -> Single<NetworkResultWithValue<T>> {
        return request(target)
            .map { result in
                let response: T? = try? result.map(T.self, using: T.decoder)
                guard let response = response else { return .error(.typeError) }
                switch result.statusCode {
                case 200:
                    return .success(response)
                    
                default:
                    guard let error = NetworkError(rawValue: response.code) else { return .error(.unknown)}
                    return .error(error)
                    
                }
            }.catchErrorJustReturn(.error(.unknown))
    }

}
