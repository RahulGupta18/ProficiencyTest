//
//  ProficiencyTestTests.swift
//  ProficiencyTestTests
//
//  Created by Mac_Admin on 20/06/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import XCTest
@testable import ProficiencyTest

class ProficiencyTestTests: XCTestCase {
    
    let path = Bundle.main.path(forResource: "Facts", ofType: "json")
    let feedTitle = "About Canada"

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Test API call
    
    func testNetworkManager() {
        
        if (Utility.isConnectedToNetwork()) {
            let promise = expectation(description: "Completion Handler invoked")
            var responseError: Error?
            var responseData: Decodable?
            NetworkManager.getDataFromServer { (facts, err) in
                if err != nil {
                    XCTAssert(false, "Can't get data from server")
                }
                responseData = facts
                responseError = err
                promise.fulfill()
            }
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertNil(responseError)
            XCTAssertNotNil(responseData)
        } else {
            print("Internet connection is required")
        }
    }
    
    /// Validates parsing using stub data
    
    func testJSONParsing() {
        
        do {
            let fileContent = try NSString(contentsOfFile: path!, encoding: String.Encoding.ascii.rawValue)
            let encodedString = fileContent.data(using: String.Encoding.utf8.rawValue)! as Data
            let parsedData = try JSONDecoder().decode(CountryFacts.self, from: encodedString)
            
            //Check whether parsing is completed successfully or not
            XCTAssertNotNil(parsedData)
            //Parsed data from Stub has 14 objects
            XCTAssertEqual(parsedData.factList?.count, 14)
            //Check for feed title
            XCTAssertEqual(parsedData.title, feedTitle)
        } catch let err{
            XCTFail("Error occured while accessing/parsing data from stub with \(err.localizedDescription)")
        }
    }
}
