//
//  MockGetCardUseCase.swift
//  TinderSwipeCardsTests
//
//  Created by Huy Quang Nguyen on 11/25/20.
//

import Foundation

@testable import TinderSwipeCards
final class MockCardsRepository: CardsRepository {
    
    public var mockPersonObjectList: [PersonObject]! = []
    public var didGetListCardsSuccessfully: Bool! = true
    public var didSaveCardSuccessfully: Bool! = true
    public var errorMessage: String! = "An error occurred"
    
    func getListPeople(results: String!,
                       completion:@escaping (Result<[PersonObject], Error>) ->Void) {
        if didGetListCardsSuccessfully {
            completion(.success(mockPersonObjectList))
        } else {
            completion(.failure(MockError.first(message: errorMessage)))
        }
    }
    
    func saveCardRepository(card: PersonObject) -> Bool! {
        return didSaveCardSuccessfully
    }
}
