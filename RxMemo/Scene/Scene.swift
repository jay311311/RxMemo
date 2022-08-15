//
//  Scene.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import UIKit


enum Scene{
    case list(ListViewModel)
    case detail(DetailViewModel)
    case edit(EditViewModel)
}

//storyboard에 있는 scen 생성 , 연관값에 저장된ViewModel을 바인딩하여 return하는 메소드
extension Scene {
    func instantiate(from storyboard:String  = "Main") -> UIViewController{
        let storyboard  =  UIStoryboard(name: storyboard, bundle: nil)
        // scene이 아닌 navigatorController를 생성해야함
        switch self {
        case .list(let listViewModel):
            guard let nav  =  storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else { fatalError() }
            guard var listVC =  nav.viewControllers.first as? ListViewController else { fatalError() }
            
            listVC.bind(viewModel: listViewModel)
            
            return nav
            
        case .detail(let detailViewModel):
            guard let nav  =  storyboard.instantiateViewController(withIdentifier: "DetailVC") as? UINavigationController else { fatalError() }
            guard var DetailVC =  nav.viewControllers.first as? DetailViewController  else { fatalError() }
            DetailVC.bind(viewModel: detailViewModel)
            
            return DetailVC
            
        case .edit(let editViewModel):
            guard let nav  =  storyboard.instantiateViewController(withIdentifier: "EditNav") as? UINavigationController else { fatalError() }
            guard var EditNav =  nav.viewControllers.first as? EditViewController  else { fatalError() }
            
            EditNav.bind(viewModel: editViewModel)
            
            return nav
        }
    }
}
