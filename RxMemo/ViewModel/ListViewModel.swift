//Mvvm패턴으로 구현시 viewModel을 viewController의 속성으로 추가한다 -> viewModel과 view를 바인딩
import Foundation
import RxSwift
import RxCocoa

// 메모 리스트에서 사용할 viewModel
class ListViewModel: CommonViewModel{
    var memoList:Observable<[Memo]>{
        return storage.memoLists()
    }
    
}
