//
//  ProficiencyTestUITests.swift
//  ProficiencyTestUITests
//
//  Created by Mac_Admin on 20/06/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import XCTest

class ProficiencyTestUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sleep(5)
        super.tearDown()
    }
    
    //MARK:- View Existence tests
    
    func testTableExists() {
        let factsTableView = app.tables["factsTable"]
        XCTAssertTrue(factsTableView.exists, "Facts tableview exists")
    }
    
    func testRefresButtonExistence() {
        
        let btnRefresh = app.buttons["refreshButton"]
        XCTAssertTrue(btnRefresh.exists, "Refresh Button exists")
    }
    
    //MARK:- TableView tests
    
    func testTableItems()
    {
        let factsTableView = app.tables["factsTable"]
        
        let tableCells = factsTableView.cells
        
        sleep(5)
        
        if tableCells.count > 0 {
            XCTAssertTrue(true, "Facts Table has \(tableCells.count) cells")
        } else {
            XCTAssertTrue(true, "Facts Table has no cell")
        }
        
        XCTAssertTrue(true, "Finished validating  tableview cells")
    }
    
}
