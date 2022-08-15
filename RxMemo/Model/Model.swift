//
//  Model.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation


struct Memo: Equatable{
    var context :String
    var date  : Date
    var identity : String
    
    init(context :String, date:Date = Date()){
        self.context = context
        self.date = date
        self.identity = "\(date.timeIntervalSinceReferenceDate)"
    }
    
    init(original : Memo, updateContext:String ){
        self = original
        self.context = updateContext
    }

}
