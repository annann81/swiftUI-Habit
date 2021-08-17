//
//  Persistence.swift
//  Habit
//
//  Created by A2006 on 2021/8/13.
//

import CoreData




final class SelectSymbolsName: ObservableObject {
    @Published var symbolsName = String()
    @Published var totlAwardNum = Int()
    
    @Published var updateAward : Award!
//    @Published var updatePlan : Plan!
    @Published var isUpdate = false
}

//final class TotlAwardNum: ObservableObject {
//  @Published var totlAwardNum = Int()
//}





struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        print(NSHomeDirectory())
        container = NSPersistentContainer(name: "Habit")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
//        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
        
    }
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
}
