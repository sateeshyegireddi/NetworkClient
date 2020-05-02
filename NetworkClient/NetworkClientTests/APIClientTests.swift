//
//  APIClientTests.swift
//  NetworkingTests
//
//  Created by Sateesh Yemireddi on 4/6/20.
//  Copyright © 2020 Company. All rights reserved.
//

import XCTest
@testable import NetworkClient

class APIClientTests: XCTestCase {
    var sut: APIClient!
    var sutOverNetwork: APIClient!
    var sutWithNilRequest: APIClient!
    let query = MockQuery(term: "AR Rehman", country: "IN")

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let urlComponent = MockURLComponent(base: BaseURL.base.rawValue,
                                            path: URLPath.search.rawValue,
                                            query: query)
        var successRequest = APIURLRequest(with: urlComponent)
        sutOverNetwork = APIClient(with: successRequest)
        successRequest.isUnderTest = true
        sut = APIClient(with: successRequest)
        
        let nilURLComponent = MockURLComponent(base: BaseURL.base.rawValue,
                                                   path: "nil")
        sutWithNilRequest = APIClient(with: MockURLRequest(with: nilURLComponent))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchDummyDataWithSuccess() {
        sut.fetch(Response<[Artist]>.self) { result in
            switch result {
            case .success(let artists):
                XCTAssertTrue(artists.resultCount > 0)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testFetchDataWithSuccess() {
        let fetchingData = self.expectation(description: "fetch artists expectation")
        sutOverNetwork.fetch(Response<[Artist]>.self) { result in
            switch result {
            case .success(let artists):
                XCTAssertTrue(artists.resultCount > 0)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            fetchingData.fulfill()
        }
        wait(for: [fetchingData], timeout: 10.0)
    }
    
    func testFetchDataWithFailure() {
        sutWithNilRequest.fetch(Response<[Artist]>.self) { result in
            switch result {
            case .success(let artists):
                XCTAssertTrue(artists.resultCount > 0)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}

struct APIURLRequest: URLRequestable {
    var urlComponent: URLComponent
    var isUnderTest: Bool = false
    init(with url: URLComponent) {
        self.urlComponent = url
    }
}
