import Foundation
import RxSwift
import RxCocoa

class ListViewModel: CommonViewModel {
    var memoList: Observable<[Memo]> {
        return storage.memoLists()
    }
}
