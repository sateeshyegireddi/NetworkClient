//
//  URLRequestableTests.swift
//  NetworkingTests
//
//  Created by Sateesh Yemireddi on 4/15/20.
//  Copyright © 2020 Company. All rights reserved.
//

import XCTest
@testable import NetworkClient

class URLRequestableTests: XCTestCase {
    var sut: URLRequestable!
    var sutWithEmptyRequest: URLRequestable!
    let query = MockQuery(term: "AR Rehman", country: "IN")
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let urlComponent = MockURLComponent(base: BaseURL.base.rawValue,
                                            path: URLPath.search.rawValue,
                                            query: query)
        sut = MockURLRequest(with: urlComponent)
        
        let nilComponent = MockURLComponent(base: "", path: "")
        sutWithEmptyRequest = EmptyURLRequest(urlComponent: nilComponent)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        sutWithEmptyRequest = nil
    }

    func testDefaultRequest() {
        XCTAssertNotNil(sut.urlRequest?.httpMethod)
        XCTAssertTrue(sut.urlRequest?.httpMethod == HTTPMethod.GET.rawValue)
        XCTAssertNotNil(sut.urlRequest?.url)
        XCTAssertNil(sut.urlRequest?.httpBody)
        XCTAssertNotNil(sut.urlRequest?.allHTTPHeaderFields)
        XCTAssertTrue(sut.urlRequest?.allHTTPHeaderFields == HTTPHeaderField.default)
        XCTAssertNil(sut.dispatchGroup)
        XCTAssertFalse(sut.isUnderTest)
    }
    
    func testEmptyURLRequest() {
        XCTAssertNotNil(sutWithEmptyRequest.urlRequest)
        XCTAssertNil(sutWithEmptyRequest.urlRequest?.url?.baseURL)
        XCTAssertTrue(sutWithEmptyRequest.urlRequest?.url?.path == "")
        XCTAssertNil(sutWithEmptyRequest.urlRequest?.url?.query)
        XCTAssertFalse(sut.isUnderTest)
    }
}

struct MockURLRequest: URLRequestable {
    var urlComponent: URLComponent
    init(with url: URLComponent) {
        self.urlComponent = url
    }
}

struct EmptyURLRequest: URLRequestable {
    var urlComponent: URLComponent
}
