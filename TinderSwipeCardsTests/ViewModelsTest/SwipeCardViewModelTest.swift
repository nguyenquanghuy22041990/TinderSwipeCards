//
//  SwipeCardViewModelTest.swift
//  TinderSwipeCardsTests
//
//  Created by Huy Quang Nguyen on 11/25/20.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import TinderSwipeCards

class SwipeCardViewModelTest: XCTestCase {
    
    var disposeBag: DisposeBag!
    var swipeCardViewModel: SwipeCardViewModel!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        disposeBag = DisposeBag()
        swipeCardViewModel = SwipeCardViewModel(personObject: PersonObject(fullName: "FullName", birthday: "22/04/1990", address: "Ho Chi Minh city", phoneNumber: "9999 9999 999", password: "abc-123", picturePath: "picturePath"))
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        swipeCardViewModel = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }

    func testWhenIntitalStateOnlyNameButtonsIsSelected() {
        let isNameButtonSelected = testScheduler.createObserver(Bool.self)
        let isBirthdayButtonSelected = testScheduler.createObserver(Bool.self)
        let isAddressButtonSelected = testScheduler.createObserver(Bool.self)
        let isPhoneNumberButtonSelected = testScheduler.createObserver(Bool.self)
        let isPasswordButtonSelected = testScheduler.createObserver(Bool.self)
        
        swipeCardViewModel.isNameButtonSelected.bind(to: isNameButtonSelected).disposed(by: DisposeBag())
        swipeCardViewModel.isDobButtonSelected.bind(to: isBirthdayButtonSelected).disposed(by: DisposeBag())
        swipeCardViewModel.isAddressButtonSelected.bind(to: isAddressButtonSelected).disposed(by: DisposeBag())
        swipeCardViewModel.isPhoneButtonSelected.bind(to: isPhoneNumberButtonSelected).disposed(by: DisposeBag())
        swipeCardViewModel.isPasswordButtonSelected.bind(to: isPasswordButtonSelected).disposed(by: DisposeBag())
        
        XCTAssertRecordedElements(isNameButtonSelected.events, [true])
        XCTAssertRecordedElements(isBirthdayButtonSelected.events, [false])
        XCTAssertRecordedElements(isAddressButtonSelected.events, [false])
        XCTAssertRecordedElements(isPhoneNumberButtonSelected.events, [false])
        XCTAssertRecordedElements(isPasswordButtonSelected.events, [false])
    }
    
    func testWhenNameButtonIsSelected_TheOthersAreUnselected() {
        let isNameButtonSelected = swipeCardViewModel.isNameButtonSelected.subscribeOn(scheduler)
        let isBirthdayButtonSelected = swipeCardViewModel.isDobButtonSelected.subscribeOn(scheduler)
        let isAddressButtonSelected = swipeCardViewModel.isAddressButtonSelected.subscribeOn(scheduler)
        let isPhoneNumberButtonSelected = swipeCardViewModel.isPhoneButtonSelected.subscribeOn(scheduler)
        let isPasswordButtonSelected = swipeCardViewModel.isPasswordButtonSelected.subscribeOn(scheduler)
        
        // When
        swipeCardViewModel.didSelectNameButton.accept(true)
        swipeCardViewModel.didSelectDobButton.accept(false)
        swipeCardViewModel.didSelectAddressButton.accept(false)
        swipeCardViewModel.didSelectPhoneButton.accept(false)
        swipeCardViewModel.didSelectPasswordButton.accept(false)
        
        XCTAssertEqual([try isNameButtonSelected.toBlocking().first(),
                        try isBirthdayButtonSelected.toBlocking().first(),
                        try isAddressButtonSelected.toBlocking().first(),
                        try isPhoneNumberButtonSelected.toBlocking().first(),
                        try isPasswordButtonSelected.toBlocking().first()],
                       [
                        true,
                        false,
                        false,
                        false,
                        false
            ])
    }
    
    func testWhenDobButtonIsSelected_TheOthersAreUnselected() {
        let isNameButtonSelected = swipeCardViewModel.isNameButtonSelected.subscribeOn(scheduler)
        let isBirthdayButtonSelected = swipeCardViewModel.isDobButtonSelected.subscribeOn(scheduler)
        let isAddressButtonSelected = swipeCardViewModel.isAddressButtonSelected.subscribeOn(scheduler)
        let isPhoneNumberButtonSelected = swipeCardViewModel.isPhoneButtonSelected.subscribeOn(scheduler)
        let isPasswordButtonSelected = swipeCardViewModel.isPasswordButtonSelected.subscribeOn(scheduler)
        
        // When
        swipeCardViewModel.didSelectNameButton.accept(false)
        swipeCardViewModel.didSelectDobButton.accept(true)
        swipeCardViewModel.didSelectAddressButton.accept(false)
        swipeCardViewModel.didSelectPhoneButton.accept(false)
        swipeCardViewModel.didSelectPasswordButton.accept(false)
        
        XCTAssertEqual([try isNameButtonSelected.toBlocking().first(),
                        try isBirthdayButtonSelected.toBlocking().first(),
                        try isAddressButtonSelected.toBlocking().first(),
                        try isPhoneNumberButtonSelected.toBlocking().first(),
                        try isPasswordButtonSelected.toBlocking().first()],
                       [
                        false,
                        true,
                        false,
                        false,
                        false
            ])
    }
    
    func testWhenAddressButtonIsSelected_TheOthersAreUnselected() {
        let isNameButtonSelected = swipeCardViewModel.isNameButtonSelected.subscribeOn(scheduler)
        let isBirthdayButtonSelected = swipeCardViewModel.isDobButtonSelected.subscribeOn(scheduler)
        let isAddressButtonSelected = swipeCardViewModel.isAddressButtonSelected.subscribeOn(scheduler)
        let isPhoneNumberButtonSelected = swipeCardViewModel.isPhoneButtonSelected.subscribeOn(scheduler)
        let isPasswordButtonSelected = swipeCardViewModel.isPasswordButtonSelected.subscribeOn(scheduler)
        
        // When
        swipeCardViewModel.didSelectNameButton.accept(false)
        swipeCardViewModel.didSelectDobButton.accept(false)
        swipeCardViewModel.didSelectAddressButton.accept(true)
        swipeCardViewModel.didSelectPhoneButton.accept(false)
        swipeCardViewModel.didSelectPasswordButton.accept(false)
        
        XCTAssertEqual([try isNameButtonSelected.toBlocking().first(),
                        try isBirthdayButtonSelected.toBlocking().first(),
                        try isAddressButtonSelected.toBlocking().first(),
                        try isPhoneNumberButtonSelected.toBlocking().first(),
                        try isPasswordButtonSelected.toBlocking().first()],
                       [
                        false,
                        false,
                        true,
                        false,
                        false
            ])
    }
    
    func testWhenPhoneButtonIsSelected_TheOthersAreUnselected() {
        let isNameButtonSelected = swipeCardViewModel.isNameButtonSelected.subscribeOn(scheduler)
        let isBirthdayButtonSelected = swipeCardViewModel.isDobButtonSelected.subscribeOn(scheduler)
        let isAddressButtonSelected = swipeCardViewModel.isAddressButtonSelected.subscribeOn(scheduler)
        let isPhoneNumberButtonSelected = swipeCardViewModel.isPhoneButtonSelected.subscribeOn(scheduler)
        let isPasswordButtonSelected = swipeCardViewModel.isPasswordButtonSelected.subscribeOn(scheduler)
        
        // When
        swipeCardViewModel.didSelectNameButton.accept(false)
        swipeCardViewModel.didSelectDobButton.accept(false)
        swipeCardViewModel.didSelectAddressButton.accept(false)
        swipeCardViewModel.didSelectPhoneButton.accept(true)
        swipeCardViewModel.didSelectPasswordButton.accept(false)
        
        XCTAssertEqual([try isNameButtonSelected.toBlocking().first(),
                        try isBirthdayButtonSelected.toBlocking().first(),
                        try isAddressButtonSelected.toBlocking().first(),
                        try isPhoneNumberButtonSelected.toBlocking().first(),
                        try isPasswordButtonSelected.toBlocking().first()],
                       [
                        false,
                        false,
                        false,
                        true,
                        false
            ])
    }
    
    func testWhenPasswordButtonIsSelected_TheOthersAreUnselected() {
        let isNameButtonSelected = swipeCardViewModel.isNameButtonSelected.subscribeOn(scheduler)
        let isBirthdayButtonSelected = swipeCardViewModel.isDobButtonSelected.subscribeOn(scheduler)
        let isAddressButtonSelected = swipeCardViewModel.isAddressButtonSelected.subscribeOn(scheduler)
        let isPhoneNumberButtonSelected = swipeCardViewModel.isPhoneButtonSelected.subscribeOn(scheduler)
        let isPasswordButtonSelected = swipeCardViewModel.isPasswordButtonSelected.subscribeOn(scheduler)
        
        // When
        swipeCardViewModel.didSelectNameButton.accept(false)
        swipeCardViewModel.didSelectDobButton.accept(false)
        swipeCardViewModel.didSelectAddressButton.accept(false)
        swipeCardViewModel.didSelectPhoneButton.accept(false)
        swipeCardViewModel.didSelectPasswordButton.accept(true)
        
        XCTAssertEqual([try isNameButtonSelected.toBlocking().first(),
                        try isBirthdayButtonSelected.toBlocking().first(),
                        try isAddressButtonSelected.toBlocking().first(),
                        try isPhoneNumberButtonSelected.toBlocking().first(),
                        try isPasswordButtonSelected.toBlocking().first()],
                       [
                        false,
                        false,
                        false,
                        false,
                        true
            ])
        
    }
}
