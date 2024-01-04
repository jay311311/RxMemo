//
//  DetailViewModel.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class DetailViewModel: CommonViewModel {
    
    let memo: Memo
    
    private var fomatter: DateFormatter = {
        let f =  DateFormatter()
        f.locale = Locale(identifier: "ko_kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
    
    var contents: BehaviorSubject<[String]>
    
     init(
        memo: Memo,
        title: String,
        sceneCoordinator: SceneCoordinatorType,
        storage: MemoStorageCRUD) {
            self.memo = memo
            contents = BehaviorSubject<[String]>(value: [
                memo.context,
                fomatter.string(from: memo.date)
            ])
            
            super.init(
                title: title,
                sceneCoordinator: sceneCoordinator,
                storage: storage
            )
    }
    
    lazy var moveToBackBtn = CocoaAction {
        return self.sceneCoordinator.close(animated: true)
            .asObservable()
            .map({ _ in })
    }
}
