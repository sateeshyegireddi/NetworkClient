//
//  InternetConnectionTests.swift
//  NetworkClientTests
//
//  Created by Sateesh Yemireddi on 5/9/20.
//  Copyright © 2020 Company. All rights reserved.
//

import XCTest
@testable import NetworkClient

class InternetConnectionTests: XCTestCase {
    var sut: InternetConnection!
    var sutNoHost: InternetConnection!
    
    override func setUp() {
        sut = InternetConnection.shared
        sutNoHost = InternetConnection.failedShared
        sut.configure()
        sutNoHost.configure()
    }

    override func tearDown() {
        sut = nil
        sutNoHost = nil
    }

    func testCheckInternetConnection() {
        let expect = self.expectation(description: "Internet Check")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssert(self.sut.isConnected == true)            
            expect.fulfill()
        }
        wait(for: [expect], timeout: 4.0)
    }

    func testCheckNoInternetConnection() {
        let expect = self.expectation(description: "Internet Check")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssert(self.sutNoHost.isConnected == false)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 4.0)
    }
}
