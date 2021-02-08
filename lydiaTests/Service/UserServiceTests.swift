//
//  HomeViewControllerTests.swift
//  lydiaTests
//
//  Created by Mohamed Tolba Sayed on 07/02/2021.
//

import XCTest
@testable import lydia

class UserServiceTests: XCTestCase {
    
    var httpClient: HttpClient!
    let session = MockURLSession()
    let viewModel = HomeViewModel()
    
    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        httpClient = HttpClient(session: session)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    
    func testGetUserUrl() {
        guard let url = URL(string: "https://.me/api/?results=10") else {
            fatalError("URL can't be empty")
        }
        httpClient.get(url: url) { (success, response) in }
        
        XCTAssert(session.lastURL == url)
    }
    
    func testCallDataLaunch() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        guard let url = URL(string: "https://.me/api/?results=10") else {
            fatalError("URL can't be empty")
        }
        httpClient.get(url: url) { (success, response) in }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testUserDataCallback() {
        let expectedData = "{}".data(using: .utf8)
        session.nextData = expectedData
        var actualData: Data?
        httpClient.get(url: URL(string: "https://.me/api/?results=10")!) { (data, error) in
            actualData = data
        }
        
        XCTAssertNotNil(actualData)
    }
    
}
