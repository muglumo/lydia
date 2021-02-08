//
//  UserDetailsTableviewCell.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 07/02/2021.
//

import Foundation
import UIKit

class UserDetailsTableViewCell: UITableViewCell {
    
    // MARK: - UI Component
    
    // set label name
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.loadColorWith(name: "grayBlack")
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // set label name
    private let labelInfo: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.loadColorWith(name: "grayBlack")
        label.font = label.font.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        selectionStyle = .blue
        
        // Add subview for cell
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelInfo)
        
        // Label title constraints
        labelTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        // Label info constraints
        labelInfo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelInfo.leftAnchor.constraint(equalTo: labelTitle.rightAnchor, constant: 12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: UserDetailsDataCell) {
        labelTitle.text = "\(item.labelTitle) :"
        labelInfo.text = item.labelInfo
    }
}
