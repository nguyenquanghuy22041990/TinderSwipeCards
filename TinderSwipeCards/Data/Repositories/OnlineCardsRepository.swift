//
//  DefaultGetCardsRepository.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import Moya
import Moya_ModelMapper
import Mapper

final class OnlineCardsRepository {
    private let provider: MoyaProvider<GetPeople>
    
    init(provider: MoyaProvider<GetPeople>) {
        self.provider = provider
    }
}

extension OnlineCardsRepository: CardsRepository {
    func getListPeople(results: String!, completion: @escaping (Result<[PersonObject], Error>) -> Void) {
        provider.request(GetPeople.get(results)){ (result) in
            if case .success(let response) = result {
                do {
                     let getCardsResult = try response.map(to: GetCardsResult.self)
                    let peopleObjects = getCardsResult.people.map({PersonObject(person: $0)})
                     completion(.success(peopleObjects))
                } catch let error {

                     completion(.failure(error))
                }
            }
        }
    }
    
    func saveCardRepository(card: PersonObject) -> Bool! {
        //TODO: Save a card to database of server - Implement later
        return true
    }

    
}

