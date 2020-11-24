//
//  SaveCardUseCase.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import Foundation

protocol SaveCardUseCase {
    func saveCard(card:PersonObject) -> Bool!
}

final class DefaultSaveCardUseCase: SaveCardUseCase {
    private let localFavoriteCardsRepository: LocalFavoriteCardsRepository
    
    init(localFavoriteCardsRepository: LocalFavoriteCardsRepository) {
        self.localFavoriteCardsRepository = localFavoriteCardsRepository
    }
    
    func saveCard(card: PersonObject) -> Bool! {
        return localFavoriteCardsRepository.saveCardRepository(card: card)
    }
    
    
}
