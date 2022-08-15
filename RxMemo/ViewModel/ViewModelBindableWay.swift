//
//  ViewModelBindable.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation
import UIKit

protocol ViewModelBindableWay{
    associatedtype ViewModelWay
    var viewModel : ViewModelWay! { get set}
    func bindViewModel()
}

extension ViewModelBindableWay where Self: UIViewController{

    mutating func bind(viewModel:Self.ViewModelWay){
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
