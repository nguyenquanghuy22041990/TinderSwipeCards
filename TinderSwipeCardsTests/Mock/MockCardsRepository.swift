//
//  MockGetCardUseCase.swift
//  TinderSwipeCardsTests
//
//  Created by Huy Quang Nguyen on 11/25/20.
//

import Foundation

@testable import TinderSwipeCards

enum SimulatedCase {
    case didGetListCardsSuccessfully
    case didGetListCardsFailed
    case didTriggerNetworkErrorMessage
}
final class MockCardsRepository: CardsRepository {
    
    public var mockPersonObjectList: [PersonObject]! = []
    public var errorMessage: String! = "An error occurred"
    public var simulatedCase: SimulatedCase = .didTriggerNetworkErrorMessage
    
    public var didSaveCardSuccessfully: Bool! = true
   
    func getListPeople(results: String!,
                       completion:@escaping (Result<[PersonObject], Error>) ->Void) {
        switch simulatedCase {
            case .didTriggerNetworkErrorMessage:
                completion(.failure(CustomError.networkError))
            break
                
            case .didGetListCardsSuccessfully:
                completion(.success(mockPersonObjectList))
            break
                
        case .didGetListCardsFailed:
            completion(.failure(MockError.first(message: errorMessage)))
        break
        }
        
    }
    
    func saveCardRepository(card: PersonObject) -> Bool! {
        return didSaveCardSuccessfully
    }
}
