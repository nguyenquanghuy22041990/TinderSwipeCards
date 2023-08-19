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
    private let saveCardRepository: SaveCardRepository
    
    init(saveCardRepository: SaveCardRepository) {
        self.saveCardRepository = saveCardRepository
    }
    
    func saveCard(card: PersonObject) -> Bool! {
        return saveCardRepository.saveCardRepository(card: card)
    }
    
    
}
