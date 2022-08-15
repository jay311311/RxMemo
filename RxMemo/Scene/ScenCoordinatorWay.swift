//
//  ScenCoordinator.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation
import RxSwift

protocol SceneCoordinatorWay{
    
    //새로운 Scene을 표시하는 메소드
    @discardableResult
    func shift(to scene :Scene ,  using style : ShiftStyle,animated: Bool ) -> Completable
   
    //현재 Scene을 닫고 이전Scene으로 돌아감
    @discardableResult
    func close(animated:Bool) -> Completable
}
