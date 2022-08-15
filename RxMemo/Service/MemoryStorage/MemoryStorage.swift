//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation
import RxSwift

//메모리에 메모를 저장하는 class
class MemoryStorage : MemoStorageCRUD{
    // 외부에서 직접 접근할 필요가 없기에 private로 선언
    // 배열은 옵저버블을 통해 외부로 전해진다.
    private var list = [
        Memo(context: "hello, rx", date: Date().addingTimeInterval(+10)),
        Memo(context: "hi, rx", date: Date().addingTimeInterval(-10))
    ]
    // 기본값을 리스트 배열로 선언하기위해 lazy 사용,
    // subject도 외부에서 직접 접근할 필요가 없기에 private로 선언
    private lazy var store =  BehaviorSubject<[Memo]>(value: list)
    
    
    //새로운 메모를 생성하고 배열에 추가
    @discardableResult
    func createMemo(context: String) -> Observable<Memo> {
        let memo = Memo(context: context)
        list.insert(memo, at: 0)
        
        // 이렇게 onNext로 방출해야 table같은경우 reload 없이 업데이트가 가능하다.
        store.onNext(list)
        return Observable.just(memo)
    }
    
    // subject 리턴. : 이메소드를 통해 클래스 외부에서 서브젝트에 접근하게된다.
    @discardableResult
    func memoLists() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func UpdateMemo(memo: Memo, context: String) -> Observable<Memo> {
        let update = Memo(original: memo, updateContext: context)
        
        if let index  =  list.firstIndex(where: { $0 == memo }){
            list.remove(at: index)
            list.insert(update, at: index)
        }
        store.onNext(list)
        return Observable.just(update)
    }
    
    @discardableResult
    func deleteMemo(memo: Memo) -> Observable<Memo> {
        if let index  =  list.firstIndex(where: { $0 == memo }){
            
            list.remove(at: index)
        }
        store.onNext(list)
        return Observable.just(memo)
    }
    
    
}
