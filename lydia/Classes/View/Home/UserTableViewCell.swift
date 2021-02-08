//
//  UserTableViewCell.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 06/02/2021.
//

import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: - UI Component
    
    private let thumbImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(named: "primary")?.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fullName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.loadColorWith(name: "grayDark")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        selectionStyle = .blue
        
        contentView.addSubview(thumbImage)
        contentView.addSubview(fullName)
        
        thumbImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        thumbImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        fullName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        fullName.leftAnchor.constraint(equalTo: thumbImage.rightAnchor, constant: 12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        thumbImage.kf.cancelDownloadTask()
    }
    
    /**
     *  Function for adding data to ui component
     */
    func configure(user: User) {
        if let url = user.picture?.thumbnail {
            thumbImage.load(url: url)
        }
        fullName.text = "\(user.name?.first ?? "--") \(user.name?.last ?? "--")"
    }
}
