//
//  Picture+CoreDataClass.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 05/02/2021.
//
//

import Foundation
import CoreData

@objc(Picture)
public class Picture: NSManagedObject, Codable {
    
    /**
     *  Enum properties of Picture
     */
    enum CodingKeys: String, CodingKey {
        case large = "large"
        case medium = "medium"
        case thumbnail = "thumbnail"
    }
    
    /**
     *  Initalizer with decoding
     */
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        guard let entity = NSEntityDescription.entity(forEntityName: NSStringFromClass(Picture.self), in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.large = try container.decodeIfPresent(URL.self, forKey: .large)
            self.medium = try container.decodeIfPresent(URL.self, forKey: .medium)
            self.thumbnail = try container.decodeIfPresent(URL.self, forKey: .thumbnail)
        } catch  {
            print("Decoding user erreur: \(error)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(large, forKey: .large)
        try container.encode(medium, forKey: .medium)
        try container.encode(thumbnail, forKey: .thumbnail)
    }
    

}
