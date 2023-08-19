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

final class MockRemoteCardsRepository: RemoteCardsRepository {
    
    public var mockPersonObjectList: [PersonObject]! = []
    public var errorMessage: String! = "An error occurred"
    public var simulatedCase: SimulatedCase = .didTriggerNetworkErrorMessage
    
    public var didSaveCardSuccessfully: Bool! = true
    
    func getListPeople(results: String!) async throws -> [PersonObject] {
        switch simulatedCase {
            case .didTriggerNetworkErrorMessage:
            throw CustomError.networkError
                
            case .didGetListCardsSuccessfully:
                return mockPersonObjectList
                
            case .didGetListCardsFailed:
                throw MockError.first(message: errorMessage)
            
        }
    }
    
    func saveCardRepository(card: PersonObject) -> Bool! {
        return didSaveCardSuccessfully
    }
}

final class MockLocalCardsRepository: LocalCardsRepository {
    
    public var mockPersonObjectList: [PersonObject]! = []
    public var errorMessage: String! = "An error occurred"
    public var simulatedCase: SimulatedCase = .didTriggerNetworkErrorMessage
    
    public var didSaveCardSuccessfully: Bool! = true
    
    func getListFavoritePeople() -> [PersonObject] {
        return mockPersonObjectList
    }
    
    func saveCardRepository(card: PersonObject) -> Bool! {
        return didSaveCardSuccessfully
    }
}

