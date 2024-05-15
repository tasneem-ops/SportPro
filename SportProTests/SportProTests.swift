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

    
    func testFetchData() throws {
        let excepectation = expectation(description: "Waiting for api result")

        RemoteDataSource<APIResultSportLeagues>().fetchData(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=34e5babdbca7fd35bfc77f1203fcf99808885b0babef7cc966572dc08ae95c2b", complitionHandler: { result,error  in
            if let error = error {
                XCTFail()
            }else{
                XCTAssertNotNil(result)
                XCTAssertEqual(result?.result?[0].leagueKey, 4)
                excepectation.fulfill()
            }
        })

     waitForExpectations(timeout: 15)
    }
    func testFetchDataCorruptedURl() throws {
        let excepectation = expectation(description: "Waiting for api result")

        RemoteDataSource<APIResultSportLeagues>().fetchData(url: "", complitionHandler: { result,error  in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            excepectation.fulfill()
        })

     waitForExpectations(timeout: 15)
    }

}
