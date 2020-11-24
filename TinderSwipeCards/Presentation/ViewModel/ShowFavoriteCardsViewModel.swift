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
    
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _favoriteCardViewModelList: BehaviorRelay<[FavoriteCardViewModel]> = BehaviorRelay<[FavoriteCardViewModel]>(value: [])
    
    init(getCardsUseCase: GetLocalFavoriteCardsUseCase, disposeBag: DisposeBag) {
        self.getCardsUseCase = getCardsUseCase
        self.disposeBag = disposeBag
        
        getCard()
    }
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var favoriteCardViewModelList: Driver<[FavoriteCardViewModel]> {
        return _favoriteCardViewModelList.asDriver()
    }
    
    var numberOfFavoriteCards: Int {
        return _favoriteCardViewModelList.value.count
    }
    
    func viewModelForCard(at index: Int) -> FavoriteCardViewModel? {
        guard index < _favoriteCardViewModelList.value.count else {
            return nil
        }
        
        return FavoriteCardViewModel(personObject: _favoriteCardViewModelList.value[index].personObject)
    }
    
    func getCard() {
        self._isFetching.accept(true)
        getCardsUseCase.excute(result: "50") { (result) in
            
            switch result {
            case .success(let people):
                let favoriteCardViewModelList = people.map({FavoriteCardViewModel(personObject: $0)})
                self._favoriteCardViewModelList.accept(favoriteCardViewModelList)
            
            case .failure( _):
                self._favoriteCardViewModelList.accept([])
            }
            self._isFetching.accept(false)
        }
    }
}
