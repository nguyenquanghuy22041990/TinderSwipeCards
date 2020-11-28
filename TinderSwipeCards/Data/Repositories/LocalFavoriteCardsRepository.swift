//
//  GetLocalFavoriteCardsRepository.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import Foundation

final class LocalFavoriteCardsRepository {
    private let favoriteCardsRepository: AnyRepository<PersonObject>
    
    init(personRepository: AnyRepository<PersonObject>) {
        self.favoriteCardsRepository = personRepository
    }
}

extension LocalFavoriteCardsRepository: CardsRepository {
    func getListPeople(results: String!, completion: @escaping (Result<[PersonObject], Error>) -> Void) {
        // Maybe in the future we will have a need to use results to get a specific number of favorite cards. Now we will get all favorite cards from local database
    
        let favoriteCardsList = favoriteCardsRepository.getAll()
        completion(.success(favoriteCardsList))
    }
    
    func saveCardRepository(card: PersonObject) -> Bool! {
        
        // I suppose that phoneNumber of every card is unique so we will check if there is a card having the same phone number exists before => just update card's information. Otherwise, we will insert this new card to database
       let predicate = NSPredicate(format: "phoneNumber == %@", card.phoneNumber)
        
       do {
        let matchPhoneNumberCards = favoriteCardsRepository.getAll(where: predicate)
            
            if (matchPhoneNumberCards.count > 0) { // Card exists before
               try favoriteCardsRepository.update(item: card)
            } else {
               try favoriteCardsRepository.insert(item: card)
            }
            
        } catch  {
            return false
        }
        
        return true
    }
}
