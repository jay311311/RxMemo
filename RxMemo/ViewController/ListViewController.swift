//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class ListViewController: UIViewController, ViewModelBindableType {
    
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var ListTable: UITableView!
    
    var viewModel: ListViewModel!
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        // 옵저버블과 테이블뷰를 바인딩하는 방식으로 진행됨
        viewModel.memoList.bind(to: ListTable.rx.items(cellIdentifier: "cell")){ index, memo, cell in
            cell.textLabel?.text = memo.context
        }
        .disposed(by: rx.disposeBag)
        
        addBtn.rx.action = viewModel.makeCreate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
