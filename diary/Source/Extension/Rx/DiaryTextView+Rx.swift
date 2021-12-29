//
//  DiaryTextView+Rx.swift
//  diary
//
//  Created by 김부성 on 2021/12/29.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: DiaryTextView {
    internal var text: ControlProperty<String?> {
        value
    }

    internal var value: ControlProperty<String?> {
        let source: Observable<String?> = Observable.deferred { [weak diaryTextView = self.base] in
            let text = diaryTextView?.textView.text
            
            let textChanged = diaryTextView?.textView.textStorage
                .rx.didProcessEditingRangeChangeInLength
                .observeOn(MainScheduler.asyncInstance)
                .map { _ in
                    return diaryTextView?.textView.textStorage.string
                }
                ?? Observable.empty()
            
            return textChanged
                .startWith(text)
        }
        
        
        let bindingObserver = Binder(self.base) { (diaryTextView, text: String?) in
            if diaryTextView.textView.text != text {
                diaryTextView.textView.text = text
            }
        }
        
        return ControlProperty(values: source, valueSink: bindingObserver)
    }
}

