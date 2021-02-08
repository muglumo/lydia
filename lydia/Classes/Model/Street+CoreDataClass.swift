//
//  Street+CoreDataClass.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 04/02/2021.
//
//

import Foundation
import CoreData

@objc(Street)
public class Street: NSManagedObject, Codable {
    
    /**
     *  Enum properties of Street
     */
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case number = "number"
    }
    
    
    /**
     *  Initalizer with decoding
     */
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        guard let entity = NSEntityDescription.entity(forEntityName: NSStringFromClass(Street.self), in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.number = try container.decode(Int16.self, forKey: .number)
        } catch {
            print("Decoding street erreur: \(error)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(number, forKey: .number)
    }

}
