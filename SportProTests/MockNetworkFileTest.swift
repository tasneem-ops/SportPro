//
//  MockNetworkFileTest.swift
//  SportProTests
//
//  Created by JETSMobileLabMini9 on 14/05/2024.
//

import Foundation
import XCTest
@testable import SportPro

final class MockNetworkFileTest : XCTestCase{
    var mockNetworkError : (any IRemoteDataSource)?
    var mockNetworkData : (any IRemoteDataSource)?
    override func setUpWithError() throws {
        mockNetworkError = MockNetworkService(shouldReturnError: true)
        mockNetworkData = MockNetworkService(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        mockNetworkError = nil
        mockNetworkData = nil
    }

    func testNetworkCallError() throws {
        mockNetworkError!.fetchData(url: ""){data, error in
           XCTAssertNotNil(error)
            XCTAssertNil(data)
        }
    }
    func testNetworkCallData() throws {
        mockNetworkData?.fetchData(url: ""){data, error in
           XCTAssertNotNil(data)
            XCTAssertNil(error)
        }
    }
}
