//
//  EditViewModel.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class EditViewModel: CommonViewModel {
    private let context: String?
    
    var initialText: Driver<String?> {
        return Observable.just(context).asDriver(onErrorJustReturn: nil)
    }
    
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    init(
        title: String,
        context: String? = nil,
        sceneCoordinator: SceneCoordinatorType,
        storage: MemoStorageCRUD,
        saveAction: Action<String, Void>? = nil,
        cancelAction: CocoaAction? = nil
    ) {
        self.context = context
        
        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            return sceneCoordinator.close(animated: true).asObservable().map{ _ in }
        }
        
        self.cancelAction = CocoaAction { _ in
            if let action = cancelAction {
                action.execute(())
            }
            return sceneCoordinator.close(animated: true).asObservable().map{ _ in }
        }
        
        super.init(
            title: title,
            sceneCoordinator: sceneCoordinator,
            storage: storage
        )
    }
}
