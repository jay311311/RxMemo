//
//  ViewModelBindable.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import UIKit

protocol ViewModelBindableType {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {

    mutating func bind(viewModel: Self.ViewModelType){
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
