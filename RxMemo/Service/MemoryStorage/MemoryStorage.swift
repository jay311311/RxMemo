//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation
import RxSwift

class MemoryStorage: MemoStorageCRUD {
    private var list = [
        Memo(context: "hello, rx", date: Date().addingTimeInterval(+10)),
        Memo(context: "hi, rx", date: Date().addingTimeInterval(-10))
    ]

    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    @discardableResult
    func createMemo(context: String) -> Observable<Memo> {
        let memo = Memo(context: context)
        list.insert(memo, at: 0)
        
        // 이렇게 onNext로 방출해야 table같은경우 reload 없이 업데이트가 가능하다.
        store.onNext(list)
        return Observable.just(memo)
    }
    
    @discardableResult
    func memoLists() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func updateMemo(memo: Memo, context: String) -> Observable<Memo> {
        let update = Memo(original: memo, updateContext: context)
        
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(update, at: index)
        }
        store.onNext(list)
        return Observable.just(update)
    }
    
    @discardableResult
    func deleteMemo(memo: Memo) -> Observable<Memo> {
        if let index  =  list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
        }
        store.onNext(list)
        return Observable.just(memo)
    }
    
    
}
