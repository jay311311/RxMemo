//
//  SceneCoordinator.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation
import RxSwift
import RxCocoa

class SceneCoordinator :SceneCoordinatorWay{
    private let bag = DisposeBag()
    private var window: UIWindow
    private var currentVC : UIViewController
    
    //위 두속성을 초기화 하는 Initializer
    required init(window :UIWindow){
        self.window = window
        currentVC = window.rootViewController!
    }
    
    
    @discardableResult
    func shift(to scene: Scene, using style: ShiftStyle, animated: Bool) -> Completable {
        //화면전환을 방출할 Subject 선언
        // 화면전환의 성공과 실패를 방출함
        let subject  = PublishSubject<Never>()
        
        //scene을생성하여 상수에 저장
        let target  = scene.instantiate()
        //전환 스타일에따라 실제 전환 처리
        switch style {
        case .root:
            currentVC = target
            window.rootViewController = target
            subject.onCompleted()
            
        case .push:
            guard let nav  = currentVC.navigationController else {
                subject.onError(ShiftError.navigatorControllerEmpty)
                break
            }
            
            nav.pushViewController(target, animated: animated)
            currentVC = target
            subject.onCompleted()
            
        case .modal:
            currentVC.present(target, animated: animated){
                subject.onCompleted()
            }
            currentVC  = target
        }
        return subject.asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        // Completable 직접 생성하는 방법
        return Completable.create { [unowned self]  completable in
            //현재Scene이 모달방식이켠 dismiss
            if let presentingVC = self.currentVC.presentingViewController{
                self.currentVC.dismiss(animated: animated){
                    self.currentVC = presentingVC
                    completable(.completed)
                }
            }
            //현재 scene이 네이게이션에 포함되어있다면 현재 scene을 pop, pop 할수 없는 상황이면 error이벤트 전달
            else if let nav = self.currentVC.navigationController{
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(ShiftError.cantPop))
                    return Disposables.create()
                }
                //네비게이션 스택의 마지막 뷰 컨트롤러를 현재 뷰컨트롤러로 지정
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            }
            else {
                completable(.error(ShiftError.unknown))
            }
            return Disposables.create()

        }
    }
}
