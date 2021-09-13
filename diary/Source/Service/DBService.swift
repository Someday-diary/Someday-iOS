//
//  RealmService.swift
//  diary
//
//  Created by 김부성 on 2021/09/12.
//

import RealmSwift
import RxSwift

protocol RealmServiceType {
    func write(_ date: Date, _ data: String, _ tags: String) -> Single<Void>
}

final class RealmService: RealmServiceType {
    
    fileprivate let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func write(_ date: Date, _ data: String, _ tags: String) -> Single<Void> {
        return Single<Void>.create { single in
            
            let diary = RealmDiary().then {
                $0.date = date.realmString
                $0.data = data
                $0.tags = tags
            }
            
            do {
                try self.realm.write {
                    self.realm.add(diary)
                }
                single(.success(Void()))
            } catch {
                single(.error(error))
            }
            
            return Disposables.create()
        }
        
    }
    
}
