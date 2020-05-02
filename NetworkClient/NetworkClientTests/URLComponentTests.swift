//
//  URLComponentTests.swift
//  NetworkingTests
//
//  Created by Sateesh Yemireddi on 4/15/20.
//  Copyright © 2020 Company. All rights reserved.
//

import XCTest
@testable import NetworkClient

class URLComponentTests: XCTestCase {
    var sut: MockURLComponent!
    var sutWithNoSchemeQuery: MockURLComponent!
    var sutWithFail: MockURLComponent!
    var sutWithNilQuery: DefaultURLComponent!
    let query = MockQuery(term: "AR Rehman", country: "IN")
    
    override func setUp() {
        sut = MockURLComponent(base: BaseURL.base.rawValue,
                               path: URLPath.search.rawValue,
                               query: query)
        sutWithNoSchemeQuery = MockURLComponent(base: BaseURL.base.rawValue,
                                                path: URLPath.search.rawValue)
        sutWithFail = MockURLComponent(base: "itunesapplecom",
                                       path: "search",
                                       query: query)
        sutWithNilQuery = DefaultURLComponent(base: BaseURL.base.rawValue,
                                              path: URLPath.search.rawValue)
    }

    override func tearDown() {
        sut = nil
        sutWithNoSchemeQuery = nil
        sutWithFail = nil
        sutWithNilQuery = nil
    }

    func testSuccessURL() {
        do {
            let url = try sut.asURL()
            XCTAssertNotNil(url.scheme)
            XCTAssertEqual(url.scheme, sut.scheme.rawValue)
            XCTAssertNotNil(url.host)
            XCTAssertEqual(url.host, BaseURL.base.rawValue)
            XCTAssertNotNil(url.path)
            XCTAssertEqual(url.path, URLPath.search.rawValue)
            XCTAssertNotNil(url.query)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testSuccessURLWithNoQuery() {
        do {
            let url = try sutWithNoSchemeQuery.asURL()
            XCTAssertNotNil(url.scheme)
            XCTAssertEqual(url.scheme, HTTPScheme.https.rawValue)
            XCTAssertNotNil(url.host)
            XCTAssertEqual(url.host, BaseURL.base.rawValue)
            XCTAssertNotNil(url.path)
            XCTAssertEqual(url.path, URLPath.search.rawValue)
            XCTAssertNil(url.query)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testFailURL() {
        do {
            let url = try sutWithFail.asURL()
            XCTAssertNotNil(url.scheme)
            XCTAssertEqual(url.scheme, sut.scheme.rawValue)
            XCTAssertNotNil(url.host)
            XCTAssertEqual(url.host, BaseURL.base.rawValue)
            XCTAssertNotNil(url.path)
            XCTAssertEqual(url.path, URLPath.search.rawValue)
            XCTAssertNotNil(url.query)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testNilURL() {
        XCTAssertNotNil(sutWithNilQuery.scheme)
        XCTAssertTrue(sutWithNilQuery.scheme == HTTPScheme.https)
        XCTAssertNil(sutWithNilQuery.query)
        do {
            let _ = try sutWithFail.asURL()
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

struct MockURLComponent: URLComponent {
    var scheme: HTTPScheme = .https
    var base: String
    var path: String
    var query: Encodable? = nil
}

struct MockQuery: Encodable {
    var term: String
    var country: String
}

struct DefaultURLComponent: URLComponent {
    var base: String
    var path: String
}
