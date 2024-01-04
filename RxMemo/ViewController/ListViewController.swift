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
    @IBOutlet weak var listTableView: UITableView!
    
    var viewModel: ListViewModel!
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList.bind(to: listTableView.rx.items(cellIdentifier: "cell")){ index, memo, cell in
            cell.textLabel?.text = memo.context
        }
        .disposed(by: rx.disposeBag)
        
        addBtn.rx.action = viewModel.makeCreate()
        
        Observable.zip(listTableView.rx.modelSelected(Memo.self), listTableView.rx.itemSelected)
            .withUnretained(self)
            .do(onNext: { (vc, data) in
                vc.listTableView.deselectRow(at: data.1, animated: true)
            })
            .map { $1.0 }
            .bind(to: viewModel.moveToDetail.inputs)
            .disposed(by: rx.disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
