//
//  DataManager.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 05/02/2021.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let managedObjectContext:  NSManagedObjectContext  = {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can't reach app delegate")
        }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return managedObjectContext
    }()
    
}
