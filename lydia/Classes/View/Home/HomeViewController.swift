//
//  ViewController.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 03/02/2021.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var safeArea: UILayoutGuide!
    let viewModel: HomeViewModel = HomeViewModel()
    
    // Cancellables
    private var cancellable: AnyCancellable?
    private var isLoadingCancellable: AnyCancellable?
    
    // MARK: - UI Component
    
    var tableView: UITableView = UITableView()
    private var cardViewContainer = UIView()
    private let spinner = UIActivityIndicatorView()
    
    private var cardView: CardView = {
        let cardview = CardView()
        cardview.backgroundColor = .white
        return cardview
    } ()
    
    private let balanceLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.loadColorWith(name: "primary")
        label.font = label.font.withSize(70)
        label.text = "190€"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logo : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fullName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.loadColorWith(name: "grayBlack")
        label.font = label.font.withSize(10)
        label.text = "Mohamed Tolba"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set Background
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        // Set UI
        setUpView()
        setTableView()
        
        if NetworkConnection.isConnectedToNetwork() {
            viewModel.deleteLocalUsers()
        } else {
            viewModel.fetchLocalUsers()
        }
        
        viewModel.getUser()
        isLoading()
        reloadTableView()
    }
    
    // MARK: - UI
    
    /**
     *  Set UI
     */
    private func setUpView() {
        view.addSubview(cardViewContainer)
        
        // CardView container constraints
        cardViewContainer.translatesAutoresizingMaskIntoConstraints = false
        cardViewContainer.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        cardViewContainer.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        cardViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cardViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        cardViewContainer.addSubview(cardView)
        
        // CardView constraints
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: cardViewContainer.topAnchor, constant: 20).isActive = true
        cardView.leftAnchor.constraint(equalTo: cardViewContainer.leftAnchor, constant: 20).isActive = true
        cardView.rightAnchor.constraint(equalTo: cardViewContainer.rightAnchor, constant: -20).isActive = true
        cardView.bottomAnchor.constraint(equalTo: cardViewContainer.bottomAnchor, constant: -20).isActive = true
        
        // CardView elements
        cardView.addSubview(balanceLabel)
        cardView.addSubview(fullName)
        cardView.addSubview(logo)
        
        // Balance label constraints
        balanceLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        balanceLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        
        // Full name label constraints
        fullName.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10).isActive = true
        fullName.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 10).isActive = true
        
        //Logo constraints
        logo.bottomAnchor.constraint(equalTo: fullName.topAnchor, constant: -8).isActive = true
        logo.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 10).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 20).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /**
     *  Create  tableview and add it in the screen
     */
    private func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: cardViewContainer.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UserTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK: - Events
    
    /**
     *  Function to observe change on users list
     */
    private func reloadTableView() {
        cancellable = viewModel.$users
            .sink() {_ in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.tableView.reloadData()
                }
            }
    }
    
    /**
     *  Function for observe loading state
     */
    private func isLoading() {
        isLoadingCancellable = viewModel.$isLoading
            .sink(receiveValue: { [weak self] in
                guard let self = self else {
                    return
                }
                if $0 {
                    self.spinner.startAnimating()
                    self.tableView.tableFooterView = self.spinner
                    self.tableView.tableFooterView?.isHidden = false
                    
                } else {
                    self.spinner.stopAnimating()
                    self.spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.tableView.bounds.width, height: CGFloat(0))
                    self.tableView.tableFooterView?.isHidden = true
                }
            })
    }
}


// MARK: - UiTableView Delegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !viewModel.isLoading && indexPath.row == viewModel.users.count - 2 {
            viewModel.getUser()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UserTableViewCell.self), for: indexPath) as! UserTableViewCell
        cell.configure(user: viewModel.users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UserDetailsViewController()
        viewController.user = viewModel.users[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

