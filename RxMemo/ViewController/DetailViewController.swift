//
//  DetailViewController.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController,ViewModelBindableType {

    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet weak var contentTableView: UITableView!
    
    var viewModel: DetailViewModel!
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.contents
            .bind(to: contentTableView.rx.items) { tableView, row, value in
                switch row {
                case 0:
                    let cell =  tableView.dequeueReusableCell(withIdentifier: "contentCell")!
                    cell.textLabel?.text = value
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell")!
                    cell.textLabel?.text = value
                    return cell
                default:
                    fatalError()
                }
                
            }
            .disposed(by: rx.disposeBag)
        
        editBtn.rx.action = viewModel.editMemo()
        shareBtn.rx.action = viewModel.shareMemo()
        deleteBtn.rx.action = viewModel.deleteMemo()
//        shareBtn.rx.tap
//            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
//            .withUnretained(self)
//            .subscribe(onNext: {(vc, _) in
//                let memo = vc.viewModel.memo.context
//                let activityView = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
//                vc.present(activityView, animated: true)
//            })
//            .disposed(by: rx.disposeBag)
        
//        var backBtn = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
//        viewModel.title
//            .drive(backBtn.rx.title)
//            .disposed(by: rx.disposeBag)
//
//        backBtn.rx.action = viewModel.moveToBackBtn
//        navigationItem.hidesBackButton = true
//        navigationItem.leftBarButtonItem = backBtn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
}
