//
//  CommonViewModel.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/16.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
    let title: Driver<String>
    
    let sceneCoordinator: SceneCoordinatorType
    let storage: MemoStorageCRUD
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageCRUD) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}
