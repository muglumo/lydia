//
//  ApiManager.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 04/02/2021.
//

import Foundation
import Combine

struct Response<T> { // 1
    let value: T
    let response: URLResponse
}

class ApiManager {
    
    // Construc base api call
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .mapError({ (error) -> Error in
                return error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
