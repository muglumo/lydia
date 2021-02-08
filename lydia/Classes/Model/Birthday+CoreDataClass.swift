//
//  Birthday+CoreDataClass.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 05/02/2021.
//
//

import Foundation
import CoreData

@objc(Birthday)
public class Birthday: NSManagedObject, Codable {
    /**
     *  Enum properties of Name
     */
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case age = "age"
    }
    
    /**
     *  Initalizer with decoding
     */
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        guard let entity = NSEntityDescription.entity(forEntityName: NSStringFromClass(Birthday.self), in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
                
        do {
            self.date = try container.decode(String.self, forKey: .date)
            self.age = try container.decode(Int16.self, forKey: .age)
            
        } catch  {
            print("Decoding birthday erreur: \(error)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(age, forKey: .age)
    }

}
