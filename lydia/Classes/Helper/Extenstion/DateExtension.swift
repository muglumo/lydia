//
//  DateExtension.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 08/02/2021.
//

import Foundation

extension String {
    func toDate(dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.date(from: self)
    }
}

extension Date {
    func toString(dateFormat: String = "dd-MM-yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}
