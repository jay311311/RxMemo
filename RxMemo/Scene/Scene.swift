//
//  Scene.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import UIKit

enum Scene {
    case list(ListViewModel)
    case detail(DetailViewModel)
    case edit(EditViewModel)
}

extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .list(let listViewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else { fatalError() }
            guard var listVC = nav.viewControllers.first as? ListViewController else { fatalError() }
            
            DispatchQueue.main.async {
                listVC.bind(viewModel: listViewModel)
            }
            return nav
            
        case .detail(let detailViewModel):
            
            guard var DetailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { fatalError() }
            DispatchQueue.main.async {
                DetailVC.bind(viewModel: detailViewModel)
            }
            return DetailVC
            
        case .edit(let editViewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "EditNav") as? UINavigationController else { fatalError() }
            guard var EditNav =  nav.viewControllers.first as? EditViewController  else { fatalError() }
            DispatchQueue.main.async {
                EditNav.bind(viewModel: editViewModel)
            }
            return nav
        }
    }
}
