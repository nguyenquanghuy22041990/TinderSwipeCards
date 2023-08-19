//
//  ShowFavoriteCardsViewModel.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/25/20.
//

import Foundation
import RxSwift
import RxCocoa

final class ShowFavoriteCardsViewModel {
    
    private let getCardsUseCase: GetLocalFavoriteCardsUseCase
    private let disposeBag: DisposeBag
    
    let isFetching = BehaviorRelay<Bool>(value: false)
    let favoriteCardViewModelList: BehaviorRelay<[FavoriteCardViewModel]> = BehaviorRelay<[FavoriteCardViewModel]>(value: [])
    
    init(getCardsUseCase: GetLocalFavoriteCardsUseCase, disposeBag: DisposeBag) {
        self.getCardsUseCase = getCardsUseCase
        self.disposeBag = disposeBag
        getFavoriteCards()
    }
    
    var numberOfFavoriteCards: Int {
        return favoriteCardViewModelList.value.count
    }
    
    func viewModelForCard(at index: Int) -> FavoriteCardViewModel? {
        guard index < favoriteCardViewModelList.value.count else {
            return nil
        }
        
        return FavoriteCardViewModel(personObject: favoriteCardViewModelList.value[index].personObject)
    }
    
    func getFavoriteCards() {
        self.isFetching.accept(true)
        let people = getCardsUseCase.excute()
        let favoriteCardViewModelList = people.map({FavoriteCardViewModel(personObject: $0)})
        self.favoriteCardViewModelList.accept(favoriteCardViewModelList)
        self.isFetching.accept(false)
    }
}
