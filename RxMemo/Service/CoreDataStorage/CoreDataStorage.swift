//
//  CoreDataStorage.swift
//  RxMemo
//
//  Created by Jooeun Kim on 2024/01/04.
//

import Foundation
import RxSwift
import RxCoreData
import CoreData

class CoreDataStorage: MemoStorageCRUD {
    // MARK: - Core Data stack
    
    let modelName: String
    init(modelName: String) {
        self.modelName = modelName
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    @discardableResult
    func createMemo(context: String) -> RxSwift.Observable<Memo> {
        let memo = Memo(context: context)
        
        do {
           _ = try mainContext.rx.update(memo)
            return Observable.just(memo)
        } catch {
            return Observable.error(error)
            
        }
    }
    
    @discardableResult
    func memoLists() -> RxSwift.Observable<[Memo]> {
        return mainContext.rx.entities(Memo.self, sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)])
//            .map { results in MemoSelectionModel(model:0, items: results)}
    }
    
    @discardableResult
    func updateMemo(memo: Memo, context: String) -> RxSwift.Observable<Memo> {
        let updated = Memo(original: memo, updateContext: context)
        
        do {
            _ = try mainContext.rx.update(updated)
            return Observable.just(updated)
        } catch {
            return Observable.error(error)
        }
    }
    
    @discardableResult
    func deleteMemo(memo: Memo) -> RxSwift.Observable<Memo> {
        do {
            _ = try mainContext.rx.delete(memo)
            return Observable.just(memo)
        } catch {
            return Observable.error(error)
        }
    }
    
    
}
