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
        
        let addressButtons = app.buttons.matching(identifier: "Address Button")
        
        if addressButtons.count > 0 {
            let firstButton = addressButtons.element(boundBy: 0)
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
        
        let phoneButtons = app.buttons.matching(identifier: "Phone Button")
        
        if phoneButtons.count > 0 {
            let firstButton = phoneButtons.element(boundBy: 0)
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
        
        let passwordButtons = app.buttons.matching(identifier: "Password Button")
        
        if passwordButtons.count > 0 {
            let firstButton = passwordButtons.element(boundBy: 0)
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
    
    func testSwipeRight50timesThereWillNoCardsLeftUntilReloadAndThereIs50FavoriteCards() throws {
        let app = XCUIApplication()
        app.launch()
        
        sleep(10)
        
        for _ in 0...49 {
            simulatedSwipeRight(app: app)
        }
        
        sleep(5)
        
        // Check there is no cards left
        XCTAssert(!app.staticTexts["My password is"].exists)
        
        app.buttons["Reload Button"].tap()
        
        sleep(10)
        
        // Check there is cards reloaded again
        XCTAssert(app.staticTexts["My name is"].exists)
        
        // Go to the favorite cards screen
        app.buttons["Favorite Button"].tap()
        
        // Wait for the screen is loaded completely
        sleep(10)
        
        // Check there should be >= 50 favorite cards in the Favorite screen
        let imageViews = app.images.matching(identifier: "Favorite Card ImageView")
        XCTAssertTrue(imageViews.count >= 50)
    }
    
    func simulatedSwipeRight(app: XCUIApplication) {
        let staticTexts = app.staticTexts.matching(identifier: "My name is")
        if (staticTexts.count > 0) {
            let firstStaticText = staticTexts.element(boundBy: 0)
            let startPoint = firstStaticText.coordinate(withNormalizedOffset: CGVector(dx: 0, dy:0)) // center of the element
            let finishPoint = startPoint.withOffset(CGVector(dx: 1000, dy:0))
            startPoint.press(forDuration: 0, thenDragTo: finishPoint)
        }
    }
}
