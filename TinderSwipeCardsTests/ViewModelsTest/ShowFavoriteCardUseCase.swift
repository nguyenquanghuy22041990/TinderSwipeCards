//
//  ShowFavoriteCardUseCase.swift
//  TinderSwipeCardsTests
//
//  Created by Huy Quang Nguyen on 11/26/20.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import TinderSwipeCards

class ShowFavoriteCardUseCase: XCTestCase {

    var disposeBag: DisposeBag!
    var showFavoriteCardsViewModel: ShowFavoriteCardsViewModel!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!
    var mockGetLocalCardRepository: MockLocalCardsRepository!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        disposeBag = DisposeBag()
        mockGetLocalCardRepository = MockLocalCardsRepository()
        
        showFavoriteCardsViewModel = ShowFavoriteCardsViewModel(getCardsUseCase: DefaultGetLocalFavoriteCardsUseCase(getCardsRepository: mockGetLocalCardRepository), disposeBag: disposeBag)
        
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        showFavoriteCardsViewModel = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }
    
    func testValuesWhenGetFavoriteCardsUnsuccessfully() throws {
        let favoriteCardViewModelListValue = showFavoriteCardsViewModel.favoriteCardViewModelList.subscribeOn(scheduler)
        
        mockGetLocalCardRepository.simulatedCase = .didGetListCardsSuccessfully
    
        showFavoriteCardsViewModel.getFavoriteCards()
        
        let favoriteCardViewModelList = try favoriteCardViewModelListValue.toBlocking().first()
        XCTAssertEqual(favoriteCardViewModelList?.count, 0)
        XCTAssertEqual(0, showFavoriteCardsViewModel.numberOfFavoriteCards)
    }
    
    func testValueWhenGetFavoriteCardsSuccessfully() throws {
        
        mockGetLocalCardRepository.simulatedCase = .didGetListCardsSuccessfully
        
        let personObject = PersonObject(fullName: "FullName", birthday: "22/04/1990", address: "Ho Chi Minh city", phoneNumber: "9999 9999 999", password: "abc-123", picturePath: "picturePath")
        mockGetLocalCardRepository.mockPersonObjectList = [personObject]
        
        showFavoriteCardsViewModel.getFavoriteCards()
        
        let cardViewModel = showFavoriteCardsViewModel.viewModelForCard(at:0)
        XCTAssertEqual(cardViewModel!.personObject.fullName, personObject.fullName)
    }
    
    func testViewModelForCardIsNilWhenIndexIsBiggerThanTheNumberOfViewModelForCard() throws {
        
        mockGetLocalCardRepository.simulatedCase = .didGetListCardsSuccessfully
        let cardViewModel = showFavoriteCardsViewModel.viewModelForCard(at:10)
        XCTAssertTrue(cardViewModel == nil)
    }
}
