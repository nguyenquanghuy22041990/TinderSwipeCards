//
//  GetLocalFavoriteCardsUseCase.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import Foundation

protocol GetLocalFavoriteCardsUseCase {
    func excute()-> [PersonObject]
}

final class DefaultGetLocalFavoriteCardsUseCase: GetLocalFavoriteCardsUseCase {
    private let getCardsRepository: LocalCardsRepository
    
    init(getCardsRepository: LocalCardsRepository) {
        self.getCardsRepository = getCardsRepository
    }
    
    func excute() -> [PersonObject] {
        self.getCardsRepository.getListFavoritePeople()
    }
}
