//
//  GetCardsUseCase.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import Foundation

protocol GetOnlineCardsUseCase {
    func excute(result: String!, completion: @escaping (Result<[PersonObject], Error>) -> Void)
}

final class DefaultGetOnlineCardsUseCase: GetOnlineCardsUseCase {
    private let getCardsRepository: CardsRepository
    
    init(getCardsRepository: CardsRepository) {
        self.getCardsRepository = getCardsRepository
    }
    
    func excute(result: String!, completion: @escaping (Result<[PersonObject], Error>) -> Void) {
        self.getCardsRepository.getListPeople(results: result, completion: completion)
    }
    
    
}
