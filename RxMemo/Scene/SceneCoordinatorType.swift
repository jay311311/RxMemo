//
//  ScenCoordinator.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {    
    @discardableResult
    func shift(to scene: Scene, using style: ShiftStyle, animated: Bool) -> Completable
   
    @discardableResult
    func close(animated: Bool) -> Completable
}
