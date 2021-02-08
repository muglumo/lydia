//
//  ImageUrlReader.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 06/02/2021.
//

import Foundation
import UIKit
import Kingfisher

// king fisher
extension UIImageView {
    func load(url: URL) {
      self.kf.setImage(with: url)
    }
}
