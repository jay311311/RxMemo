//
//  DetailViewController.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import UIKit

class DetailViewController: UIViewController,ViewModelBindableType {

    @IBOutlet weak var deleteBtn: UIToolbar!
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
