//
//  APITransportTests.swift
//  NetworkingTests
//
//  Created by Sateesh Yemireddi on 4/6/20.
//  Copyright © 2020 Company. All rights reserved.
//

import XCTest
@testable import NetworkClient

class APITransportTests: XCTestCase {
    var sut: MockTransport!
    var urlRequest: URLRequest!
    var failURLRequest: URLRequest!
    let query = MockQuery(term: "AR Rehman", country: "IN")

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = MockTransport()
        let urlComponent = MockURLComponent(base: BaseURL.base.rawValue,
                                            path: URLPath.search.rawValue,
                                            query: query)
        urlRequest = MockURLRequest(with: urlComponent).urlRequest
        let failURLComponent = MockURLComponent(base: "itunes.apple",
                                                path: URLPath.search.rawValue)
        failURLRequest = MockURLRequest(with: failURLComponent).urlRequest

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        urlRequest = nil
        failURLRequest = nil
    }

    func testSuccessSearchArtist() {
        let expect = expectation(description: "Async Request")
        sut.fetch(request: urlRequest) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testFailSearchArtist() {
        let expect = expectation(description: "Async Request")
        sut.fetch(request: failURLRequest) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
//func test__Failure() {
//    let expect = expectation(description: "Your expectation")
//    self.simulateRequestFailure() { //callback
//        XCTAssertTrue(self.vm.isToast)
//        expect.fulfill()
//    }
//    waitForExpectations(timeout: 5.0, handler: nil) //5.0 - Approx. time in sec took for a request to be completed.
//}
}

struct MockTransport: Transport {
    var base: Transport
    init(_ transport: Transport = URLSession.shared) {
        base = transport
    }
    func fetch(request: URLRequest, completion: @escaping ServiceHandler) {
        base.fetch(request: request, completion: completion)
    }
}
