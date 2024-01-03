import Foundation
import RxSwift
import RxCocoa
import Action

class ListViewModel: CommonViewModel {
    
    var memoList: Observable<[Memo]> {
        return storage.memoLists()
    }
    
    func makeCreate() -> CocoaAction {
        return CocoaAction{ _ in
            return self.storage.createMemo(context: "")
                .flatMap { memo -> Observable<Void> in
                    let editViewModel = EditViewModel(
                        title: "new Memo",
                        sceneCoordinator: self.sceneCoordinator,
                        storage: self.storage,
                        saveAction: self.saveMemo(memo: memo),
                        cancelAction: self.cancleMemo(memo: memo)
                    )
                    
                    let editScene = Scene.edit(editViewModel)
                    
                    return self.sceneCoordinator.shift(to: editScene, using: .modal, animated: true)
                        .asObservable()
                        .map { _ in }
                }
        }
    }
    
    func saveMemo(memo: Memo) -> Action<String, Void> {
        return Action { input  in
            return self.storage.updateMemo(memo: memo, context: input).map { _ in }
        }
    }
    
    func cancleMemo(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.deleteMemo(memo: memo).map { _ in }
        }
    }
}
