//
//  Name+CoreDataClass.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 04/02/2021.
//
//

import Foundation
import CoreData

@objc(Name)
public class Name: NSManagedObject, Decodable, Encodable {
    
    /**
     *  Enum properties of Name
     */
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case first = "first"
        case last = "last"
    }
    
    /**
     *  Initalizer with decoding
     */
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        guard let entity = NSEntityDescription.entity(forEntityName: NSStringFromClass(Name.self), in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.title = try container.decodeIfPresent(String.self, forKey: .title)
            self.first = try container.decodeIfPresent(String.self, forKey: .first)
            self.last = try container.decodeIfPresent(String.self, forKey: .last)
        } catch  {
            print("Decoding name erreur: \(error)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(first, forKey: .first)
        try container.encode(last, forKey: .last)
    }
    
}
