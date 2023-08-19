//
//  ShowCardsViewModelTest.swift
//  TinderSwipeCardsTests
//
//  Created by Huy Quang Nguyen on 11/25/20.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import TinderSwipeCards
class ShowCardsViewModelTest: XCTestCase {

    var disposeBag: DisposeBag!
    var showCardsViewModel: ShowCardsViewModel!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!
    var mockGetRemoteCardRepository: MockRemoteCardsRepository!
    var mockSaveCardRepository: MockLocalCardsRepository!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        disposeBag = DisposeBag()
        mockGetRemoteCardRepository = MockRemoteCardsRepository()
        mockSaveCardRepository = MockLocalCardsRepository()
        
        showCardsViewModel = ShowCardsViewModel(getCardsUseCase: DefaultGetRemoteCardsUseCase(getCardsRepository: mockGetRemoteCardRepository), saveCardUseCase: DefaultSaveCardUseCase(saveCardRepository: mockSaveCardRepository), disposeBag: disposeBag)
        
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        showCardsViewModel = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }
    
    func testIsFetchingValue() {
        let isFetching = showCardsViewModel.isFetching.subscribeOn(scheduler)
        showCardsViewModel.isFetching.accept(true)
    
        XCTAssertEqual(try isFetching.toBlocking().first(), true)
    }
    
    func testInfoValue() {
        let infoMessage = showCardsViewModel.info.subscribeOn(scheduler)
        showCardsViewModel.info.accept("An error occurred")
        
        XCTAssertEqual(try infoMessage.toBlocking().first(), "An error occurred")
    }
    
    func testValuesWhenCallApiSuccessfully() async throws {
        let swipeCardViewModelListValue = showCardsViewModel.swipeCardViewModelList.subscribeOn(scheduler)
        let infoMessage = showCardsViewModel.info.subscribeOn(scheduler)
        let isFetching = showCardsViewModel.isFetching.subscribeOn(scheduler)
        
        mockGetRemoteCardRepository.simulatedCase = .didGetListCardsSuccessfully
        
        let personObject = PersonObject(fullName: "FullName", birthday: "22/04/1990", address: "Ho Chi Minh city", phoneNumber: "9999 9999 999", password: "abc-123", picturePath: "picturePath")
        mockGetRemoteCardRepository.mockPersonObjectList = [personObject]
        
        await showCardsViewModel.getCards()
        
        let cardViewModelList = try swipeCardViewModelListValue.toBlocking().first()
        XCTAssertEqual(cardViewModelList?.count, 1)
        XCTAssertEqual(try infoMessage.toBlocking().first(), "")
        XCTAssertEqual(try isFetching.toBlocking().first(), false)
    }
    
    func testValuesWhenCallApiUnsuccessfully() async throws {
        let swipeCardViewModelListValue = showCardsViewModel.swipeCardViewModelList.subscribeOn(scheduler)
        let infoMessage = showCardsViewModel.info.subscribeOn(scheduler)
        let isFetching = showCardsViewModel.isFetching.subscribeOn(scheduler)
        
        mockGetRemoteCardRepository.simulatedCase = .didGetListCardsFailed
    
        await showCardsViewModel.getCards()
        
        let cardViewModelList = try swipeCardViewModelListValue.toBlocking().first()
        XCTAssertEqual(cardViewModelList?.count, 0)
        XCTAssertEqual(0, showCardsViewModel.numberOfCards)
         
        let errorMessage = try infoMessage.toBlocking().first()
        XCTAssertTrue(errorMessage!!.range(of: "There was something wrong with the request!") != nil)
        XCTAssertEqual(try isFetching.toBlocking().first(), false)
    }
    
    func testValuesWhenNetworkIsUnavailable() async throws {
        let swipeCardViewModelListValue = showCardsViewModel.swipeCardViewModelList.subscribeOn(scheduler)
        let infoMessage = showCardsViewModel.info.subscribeOn(scheduler)
        let isFetching = showCardsViewModel.isFetching.subscribeOn(scheduler)
        
        mockGetRemoteCardRepository.simulatedCase = .didTriggerNetworkErrorMessage
    
        await showCardsViewModel.getCards()
        
        let cardViewModelList = try swipeCardViewModelListValue.toBlocking().first()
        XCTAssertEqual(cardViewModelList?.count, 0)
        XCTAssertEqual(0, showCardsViewModel.numberOfCards)
         
        let errorMessage = try infoMessage.toBlocking().first()
        XCTAssertTrue(errorMessage!!.range(of: "Network error.") != nil)
        XCTAssertEqual(try isFetching.toBlocking().first(), false)
    }
    
    func testViewModelForCardWhenCallApiSuccessfully() async throws {
        
        mockGetRemoteCardRepository.simulatedCase = .didGetListCardsSuccessfully
        
        let personObject = PersonObject(fullName: "FullName", birthday: "22/04/1990", address: "Ho Chi Minh city", phoneNumber: "9999 9999 999", password: "abc-123", picturePath: "picturePath")
        mockGetRemoteCardRepository.mockPersonObjectList = [personObject]
        
        await showCardsViewModel.getCards()
        
        let cardViewModel = showCardsViewModel.viewModelForCard(at:0)
        XCTAssertEqual(cardViewModel!.personObject.fullName, personObject.fullName)
    }
    
    func testViewModelForCardIsNilWhenIndexIsBiggerThanTheNumberOfViewModelForCard() throws {
        
        mockGetRemoteCardRepository.simulatedCase = .didGetListCardsSuccessfully
        let cardViewModel = showCardsViewModel.viewModelForCard(at:10)
        XCTAssertTrue(cardViewModel == nil)
    }
    
    func testSaveCardSuccessfully() throws {
        
        mockGetRemoteCardRepository.didSaveCardSuccessfully = true
        
        let personObject = PersonObject(fullName: "FullName", birthday: "22/04/1990", address: "Ho Chi Minh city", phoneNumber: "9999 9999 999", password: "abc-123", picturePath: "picturePath")
        mockGetRemoteCardRepository.mockPersonObjectList = [personObject]
        
        let saveCardResult = showCardsViewModel.saveCard(personObject: personObject)
        
        XCTAssertEqual(saveCardResult, true)
    }
}
