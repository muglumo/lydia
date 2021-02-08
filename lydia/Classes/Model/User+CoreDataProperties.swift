//
//  User+CoreDataProperties.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 03/02/2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?

}

extension User : Identifiable {

}
