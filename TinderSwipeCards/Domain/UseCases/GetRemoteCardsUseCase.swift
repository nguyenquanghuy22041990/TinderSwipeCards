//
//  GetCardsUseCase.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import Foundation

protocol GetRemoteCardsUseCase {
    func excute(results: String!) async throws -> [PersonObject]
}

final class DefaultGetRemoteCardsUseCase: GetRemoteCardsUseCase {
    private let getCardsRepository: RemoteCardsRepository
    
    init(getCardsRepository: RemoteCardsRepository) {
        self.getCardsRepository = getCardsRepository
    }
    
    func excute(results: String!) async throws -> [PersonObject] {
        try await self.getCardsRepository.getListPeople(results: results)
    }
    
    
}
