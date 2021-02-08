//
//  User+CoreDataClass.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 03/02/2021.
//
//

import Foundation
import CoreData
import UIKit

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}

@objc(User)
public class User: NSManagedObject, Codable {
    
    /**
     *  Enum properties of User
     */
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case gender = "gender"
        case phone = "phone"
        case cell = "cell"
        case nat = "nat"
        case name = "name"
        case location = "location"
        case birdthday = "dob"
        case picture = "picture"
    }
    
    /**
     *  Initalizer with decoding
     */
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        guard let entity = NSEntityDescription.entity(forEntityName: NSStringFromClass(User.self), in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
                
        do {
            self.email = try container.decodeIfPresent(String.self, forKey: .email)
            self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
            self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
            self.cell = try container.decodeIfPresent(String.self, forKey: .cell)
            self.nat = try container.decodeIfPresent(String.self, forKey: .nat)
            self.name = try container.decodeIfPresent(Name.self, forKey: .name)
            self.birthday = try container.decodeIfPresent(Birthday.self, forKey: .birdthday)
            self.location = try container.decodeIfPresent(Location.self, forKey: .location)
            self.picture = try container.decodeIfPresent(Picture.self, forKey: .picture)
        } catch {
            print("Decoding user erreur: \(error)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(gender, forKey: .gender)
        try container.encode(phone, forKey: .phone)
        try container.encode(cell, forKey: .cell)
        try container.encode(name, forKey: .name)
        try container.encode(birthday, forKey: .birdthday)
        try container.encode(location, forKey: .location)
        try container.encode(picture, forKey: .picture)
      }
}

