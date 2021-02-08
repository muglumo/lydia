//
//  UserRepository.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 05/02/2021.
//

import Foundation
import CoreData


class UserRepository {
    
    private let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: NSStringFromClass(User.self))
    
    /**
     *  Delete all instance of user in coredata
     */
    func deleteAll() {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try DataManager.managedObjectContext.execute(batchDeleteRequest)
            
        } catch {
            fatalError("ERROR Delete")
        }
    }
    
    /**
     *  Fetch all instance of user in coredata
     */
    func fetchAll() -> [User] {
        request.returnsObjectsAsFaults = false
        do {
            let result = try DataManager.managedObjectContext.fetch(request) as! [User]
            return result
            
        } catch {
            fatalError("ERROR Fetch")
        }
    }
}
