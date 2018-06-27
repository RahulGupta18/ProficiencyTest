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
    
}
