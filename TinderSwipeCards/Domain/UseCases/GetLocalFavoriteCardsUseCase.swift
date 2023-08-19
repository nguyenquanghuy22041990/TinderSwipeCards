//
//  GetLocalFavoriteCardsUseCase.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import Foundation

protocol GetLocalFavoriteCardsUseCase {
    func excute(results: String!, completion: @escaping (Result<[PersonObject], Error>) -> Void)
}

final class DefaultGetLocalFavoriteCardsUseCase: GetLocalFavoriteCardsUseCase {
    private let getCardsRepository: CardsRepository
    
    init(getCardsRepository: CardsRepository) {
        self.getCardsRepository = getCardsRepository
    }
    
    func excute(results: String!, completion: @escaping (Result<[PersonObject], Error>) -> Void) {
        self.getCardsRepository.getListPeople(results: results, completion: completion)
    }
    
    
}
