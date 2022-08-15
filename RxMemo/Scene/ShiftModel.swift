//
//  ShiftModel.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation


//전환방식을 표현하는 열거형

enum ShiftStyle{
    case root
    case push
    case modal
}


enum ShiftError:Error{
    case navigatorControllerEmpty
    case cantPop
    case unknown
}
