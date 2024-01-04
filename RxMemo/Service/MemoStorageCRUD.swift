//
//  MemoStoregeCRUD.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation
import RxSwift

protocol MemoStorageCRUD {
    
    @discardableResult
    func createMemo(context: String) -> Observable<Memo>
    
    @discardableResult
    func memoLists() -> Observable<[Memo]>
    
    
    @discardableResult
    func updateMemo(memo: Memo, context: String) -> Observable<Memo>
    
    @discardableResult
    func deleteMemo(memo: Memo) -> Observable<Memo>
}


