//
//  GetCardsRepository.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation

protocol SaveCardRepository {
    func saveCardRepository(card: PersonObject) -> Bool!
}

protocol RemoteCardsRepository: SaveCardRepository {
    func getListPeople(results: String!) async throws -> [PersonObject]
}

protocol LocalCardsRepository: SaveCardRepository {
    func getListFavoritePeople() -> [PersonObject]
}


