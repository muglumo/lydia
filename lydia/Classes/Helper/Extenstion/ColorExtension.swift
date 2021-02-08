//
//  ColorExtension.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 08/02/2021.
//

import Foundation
import UIKit

extension UIColor {    
    class func loadColorWith( name: String) -> UIColor {
        guard let color = UIColor(named: name) else { fatalError("Couln't find \(name) color") }
        
        return color
    }
    
}
