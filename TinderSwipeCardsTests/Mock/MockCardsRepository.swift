//
//  MockGetCardUseCase.swift
//  TinderSwipeCardsTests
//
//  Created by Huy Quang Nguyen on 11/25/20.
//

import Foundation

final class MockCardsRepository: CardsRepository {
    
    var mockPersonObjectList: [PersonObject]!
    var isSuccessful: Bool!
    var errorMessage: String! = ""
    
    func getListPeople(results: String!,
                       completion:@escaping (Result<[PersonObject], Error>) ->Void) {
        if isSuccessful {
            completion(.success(peopleObjects))
        } else {
            completion(.failure(MockError.first(message: errorMessage)))
        }
    }
    
    func saveCardRepository(card: PersonObject) -> Bool! {
        return true
    }
}
