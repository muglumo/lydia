//
//  Location+CoreDataClass.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 04/02/2021.
//
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject, Codable {
    
    /**
     *  Enum properties of User
     */
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case country = "country"
        case postcode = "postcode"
        case state = "state"
        case street = "street"
    }
    
    /**
     *  Initalizer with decoding
     */
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        guard let entity = NSEntityDescription.entity(forEntityName: NSStringFromClass(Location.self), in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.city = try container.decodeIfPresent(String.self, forKey: .city)
            self.country = try container.decodeIfPresent(String.self, forKey: .country)
            self.state = try container.decodeIfPresent(String.self, forKey: .state)
            self.street = try container.decodeIfPresent(Street.self, forKey: .street)
        } catch {
            print("Location Location erreur: \(error)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(city, forKey: .city)
        try container.encode(country, forKey: .country)
        try container.encode(state, forKey: .state)
        try container.encode(street, forKey: .street)
    }

}
