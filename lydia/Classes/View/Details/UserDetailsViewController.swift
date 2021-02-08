//
//  UserDetailsViewController.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 06/02/2021.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = UserDetailsViewModel()
    
    var user: User? {
        didSet {
            userDetailCellList = viewModel.getDataCellList(user: user)
        }
    }
    
    var userDetailCellList: [UserDetailsDataCell] = []
    // MARK: - UI Component
    
    var tableView: UITableView = UITableView()
    
    private let picture : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 45
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.loadColorWith(name: "primary").cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fullName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.loadColorWith(name: "grayDark")
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aliasName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.loadColorWith(name: "primary")
        label.font = label.font.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separator : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.loadColorWith(name: "grayNormal")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Details"
        self.view.backgroundColor = .white
        
        // Set UI
        setUpView()
        setTableView()
        
        // Get data from user
        getUserInfoHeader()
    }
    
    // MARK: - UI
    
    /**
     *  Set UI of the view
     */
    private func setUpView() {
        view.addSubview(picture)
        view.addSubview(fullName)
        view.addSubview(aliasName)
        view.addSubview(separator)
        
        // Picture constraint
        picture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        picture.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        picture.widthAnchor.constraint(equalToConstant: 90).isActive = true
        picture.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        // Full name constraint
        fullName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fullName.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 10).isActive = true
        
        // Alias constraint
        aliasName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aliasName.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 3).isActive = true
        
        // Separator constraint
        separator.topAnchor.constraint(equalTo: aliasName.bottomAnchor, constant: 40).isActive = true
        separator.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        separator.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    /**
     *  Create  tableview and add it in the screen
     */
    func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: separator.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.register(UserDetailsTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UserDetailsTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.alwaysBounceVertical = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /**
     *  Function to get user info for de hearder
     */
    private func getUserInfoHeader() {
        guard let user = user else {
            return
        }
        if let url = user.picture?.thumbnail {
            picture.load(url: url)
        }
        fullName.text = "\(user.name?.first ?? "--") \(user.name?.last ?? "--")"
        aliasName.text = "@\(user.name?.first?.lowercased() ?? "--")"
    }
    
}

// MARK: - UiTableView Delegate

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailCellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UserDetailsTableViewCell.self), for: indexPath) as! UserDetailsTableViewCell
        cell.configure(item: userDetailCellList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
