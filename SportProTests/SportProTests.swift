//
//  SportProTests.swift
//  SportProTests
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

import XCTest
@testable import SportPro

final class SportProTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFEtchData() throws {
        let excepectation = expectation(description: "Waiting for api result")
        
//        RemoteDataSource<<#Result: Decodable#>>().fetchData(url: "", complitionHandler: { Result in
//            <#code#>
//        })
//        .fetchData { result, error in
//            if let error = error {
//                XCTFail()
//            }else{
//                XCTAssertEqual(result?.data?[0].id, 1)
//                excepectation.fulfill()
//            }
       //`z  }
        
     waitForExpectations(timeout: 5)
    }

    func testExample() throws {
        XCTAssert(true)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
