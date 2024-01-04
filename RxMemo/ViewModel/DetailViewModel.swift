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
    
    func saveMemo(memo: Memo) -> Action<String, Void> {
        return Action { input  in
             self.storage.updateMemo(memo: memo, context: input)
                .map { [$0.context, self.fomatter.string(from: $0.date)] }
                .subscribe(onNext: { self.contents.onNext($0) })
                .disposed(by: self.rx.disposeBag)
            
            return Observable.empty()
        }
    }
    
    func editMemo() -> CocoaAction {
        return CocoaAction { _ in
            let editViewModel = EditViewModel(
                title: "메모 편집",
                context: self.memo.context,
                sceneCoordinator: self.sceneCoordinator,
                storage: self.storage,
                saveAction: self.saveMemo(memo: self.memo)
            )
            
            let editScene = Scene.edit(editViewModel)
            
            return self.sceneCoordinator.shift(to: editScene, using: .modal, animated: true)
                .asObservable()
                .map { _ in }
        }
    }
    
    func shareMemo() -> CocoaAction {
        return CocoaAction { _ in
            let memo = self.memo.context
            
            return self.sceneCoordinator.share(memo: memo, animated: true)
                .asObservable()
                .map { _ in }
        }
    }
    
    func deleteMemo() -> CocoaAction {
        return Action { inputs in
            self.storage.deleteMemo(memo: self.memo)

            return self.sceneCoordinator.close(animated: true)
                .asObservable()
                .map { _ in }
        }
    }
}
