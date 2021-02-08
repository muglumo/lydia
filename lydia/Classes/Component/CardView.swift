//
//  CardView.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 06/02/2021.
//

import Foundation
import UIKit


class CardView: UIView {
    var cornerRadius: CGFloat = 4
    var shadowOffsetWidth: Int = 2
    var shadowOffsetHeight: Int = 2
    var shadowColor: UIColor? = .black
    var shadowOpacity: Float = 0.5
    
    /*Set UIView properties to get cardview effect*/
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}
