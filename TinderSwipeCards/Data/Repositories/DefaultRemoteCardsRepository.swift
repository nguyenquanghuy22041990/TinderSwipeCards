//
//  DefaultGetCardsRepository.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import Moya
import Moya_ModelMapper
import Mapper

final class DefaultRemoteCardsRepository {
    private let provider: MoyaProvider<GetPeople>
    private let checkNetworkManager: CheckNetworkManager
    
    init(provider: MoyaProvider<GetPeople>, checkNetworkManager: CheckNetworkManager) {
        self.provider = provider
        self.checkNetworkManager = checkNetworkManager
    }
}

enum CustomError: Error {
    case networkError
}

extension DefaultRemoteCardsRepository: RemoteCardsRepository {
    func getListPeople(results: String!) async throws -> [PersonObject] {
        return try await withCheckedThrowingContinuation { continuation in
            checkNetworkManager.checkNetworkConnection { [self] in
                provider.request(GetPeople.get(results)){ (result) in
                    if case .success(let response) = result {
                        do {
                            let getCardsResult = try response.map(to: GetCardsResult.self)
                            let peopleObjects = getCardsResult.people.map({PersonObject(person: $0)})
                            continuation.resume(with: .success(peopleObjects))
                        } catch let error {
                            continuation.resume(with: .failure(error))
                        }
                    }
                }
            } onNetworkError: {
                continuation.resume(with: .failure(CustomError.networkError))
            }
        }
    }
    
    func saveCardRepository(card: PersonObject) -> Bool! {
        //TODO: Save a card to database of server - Implement later
        return true
    }
}

