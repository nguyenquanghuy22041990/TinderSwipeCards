//
//  GetCardsRepository.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation

protocol CardsRepository {
    func getListPeople(results: String!,
                       completion:@escaping (Result<[PersonObject], Error>) ->Void)
    
    func saveCardRepository(card: PersonObject) -> Bool!
}


