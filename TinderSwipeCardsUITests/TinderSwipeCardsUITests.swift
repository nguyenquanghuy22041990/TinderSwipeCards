//
//  TinderSwipeCardsUITests.swift
//  TinderSwipeCardsUITests
//
//  Created by Huy Quang Nguyen on 11/20/20.
//

import XCTest

class TinderSwipeCardsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//
//        app.launch()
//
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
    
    func testFirstNameTabIsSelectedByDefault() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Wait for the screen is loaded completely
        sleep(10)
        
        // First tab will display "My name is"
        XCTAssert(app.staticTexts["My name is"].exists)
    }
    
    func testMyBirthdayIsDisplayedWhenTapDOBTab() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Wait for the screen is loaded completely
        sleep(10)
        
        let dobButtons = app.buttons.matching(identifier: "DOB Button")
        
        if dobButtons.count > 0 {
            let firstButton = dobButtons.element(boundBy: 0)
            firstButton.tap()
        }

        // First tab will display "My birthday is"
        
        XCTAssert(app.staticTexts["My birthday is"].exists)
    }
    
    func testMyAddressIsDisplayedWhenTapAddressTab() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Wait for the screen is loaded completely
        sleep(10)
        
        let dobButtons = app.buttons.matching(identifier: "Address Button")
        
        if dobButtons.count > 0 {
            let firstButton = dobButtons.element(boundBy: 0)
            firstButton.tap()
        }

        // First tab will display "My address is"
        XCTAssert(app.staticTexts["My address is"].exists)
    }
    
    func testMyPhoneNumberIsDisplayedWhenTappingPhoneTab() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Wait for the screen is loaded completely
        sleep(10)
        
        let dobButtons = app.buttons.matching(identifier: "Phone Button")
        
        if dobButtons.count > 0 {
            let firstButton = dobButtons.element(boundBy: 0)
            firstButton.tap()
        }

        // First tab will display "My phone number is"
        XCTAssert(app.staticTexts["My phone number is"].exists)
    }
    
    func testMyPasswordIsDisplayedWhenTappingPasswordTab() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Wait for the screen is loaded completely
        sleep(10)
        
        let dobButtons = app.buttons.matching(identifier: "Password Button")
        
        if dobButtons.count > 0 {
            let firstButton = dobButtons.element(boundBy: 0)
            firstButton.tap()
        }

        // First tab will display "My password is"
        XCTAssert(app.staticTexts["My password is"].exists)
    }
    
    func testNavigateToFavoriteScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Favorite Button"].tap()
        
        // Wait for the screen is loaded completely
        sleep(10)
        
        // Check the title screen is shown
        XCTAssert(app.staticTexts["Favorite Cards"].exists)
    }
}
