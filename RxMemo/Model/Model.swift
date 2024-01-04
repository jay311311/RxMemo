//
//  Model.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2022/08/15.
//

import Foundation
import RxCoreData
import CoreData

struct Memo: Equatable {
    var context: String
    var date: Date
    var identity: String
    
    init(context: String, date: Date = Date()) {
        self.context = context
        self.date = date
        self.identity = "\(date.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo, updateContext:String) {
        self = original
        self.context = updateContext
    }
}

extension Memo: Persistable {
    static var entityName: String {
        return "Memo"
    }
    
    static var primaryAttributeName: String {
        return "identity"
    }
    
    init(entity: NSManagedObject) {
        context = entity.value(forKey: "context") as! String
        date = entity.value(forKey: "date") as! Date
        identity = "\(date.timeIntervalSinceReferenceDate)"
    }
    
    func update(_ entity: NSManagedObject) {
        entity.setValue(context, forKey: "context")
        entity.setValue(date, forKey: "date")
        entity.setValue("\(date.timeIntervalSinceReferenceDate)", forKey: "identity")
        
        do {
            try entity.managedObjectContext?.save()
        } catch {
            print(error)
        }
    }

}
