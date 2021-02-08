//
//  MockURLSessionDataTask.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 07/02/2021.
//

import Foundation

/**
 *  Check if data task called
 */
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}

