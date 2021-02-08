//
//  UserService.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 03/02/2021.
//

import Foundation
import Combine

struct UserResponse: Decodable {
    let users: [User]
    
    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}

protocol UserService {
    func getUsers(number: Int, decoder: JSONDecoder) -> AnyPublisher<UserResponse, Error>
}

class UserServiceImpl: UserService {
    
    // URL for Api GET Users Api call
    private let  UserUrlString = "https://randomuser.me/api/"
    
    /**
     *  Function for Making API request and return Publish
     */
    func getUsers(number: Int, decoder: JSONDecoder) -> AnyPublisher<UserResponse, Error> {
        
        // Set url comoponent
        guard var components = URLComponents(string: UserUrlString) else {
            fatalError("Component URL NOT FOUND")
        }
        
        // Set params
        let queryItemResults = URLQueryItem(name: "results", value: "\(number)")
        components.queryItems = [queryItemResults]
        
        // get url
        guard let url = components.url else {
            fatalError("URL NOT FOUND")
        }
        
        // Set request
        var request = URLRequest(url: url)
        request.httpMethod = APIMethod.get.rawValue
        
        // Making request
        return ApiManager().run(request, decoder)
            .map(\.value)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
