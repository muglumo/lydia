//
//  HomeViewModel.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 03/02/2021.
//

import Combine
import UIKit
import CoreData

class HomeViewModel {
    
    // MARK: - Properties
    
    private var userService: UserServiceImpl
    private var userRepository: UserRepository
    
    @Published var users: [User] = []
    @Published var isLoading = false
    
    var cancellable: AnyCancellable?
    let decoder = JSONDecoder()
    
    // MARK: - Init
    init(userService: UserServiceImpl = UserServiceImpl(), userRepository: UserRepository = UserRepository()) {
        self.userService = userService
        self.userRepository = userRepository
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = DataManager.managedObjectContext
    }
    
    /**
     *  Function making api call to get 10 users
     */
    func getUser() {
        self.isLoading.toggle()
        // Api call
        cancellable = userService.getUsers(number: 10, decoder: decoder)
            .mapError({ (error) -> Error in // 5
                print(error)
                return error
            })
            .sink(receiveCompletion: { completion in
                // When the request has ended
                self.isLoading.toggle()
                switch completion {
                case .finished:
                    print("call finished")
                case .failure(let error):
                    print("Error", error)
                }
            },
            receiveValue: {_ in
                self.users = self.userRepository.fetchAll()
            })
    }
    
    /**
     *  Function Delete all instance of user in coredata
     */
    func deleteLocalUsers() {
        userRepository.deleteAll()
    }
    
    /**
     *  Function for set users tableview with local user
     */
    func fetchLocalUsers() {
        users = userRepository.fetchAll()
    }
    
}
