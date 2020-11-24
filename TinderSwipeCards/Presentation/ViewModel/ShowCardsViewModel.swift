//
//  GetCardsViewModel.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import Foundation
import RxSwift
import RxCocoa

final class ShowCardsViewModel {
    private let getCardsUseCase: GetOnlineCardsUseCase
    private let saveCardUseCase: SaveCardUseCase
    private let disposeBag: DisposeBag
    
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _info = BehaviorRelay<String?>(value: "")
    private let _swipeCardViewModelList: BehaviorRelay<[SwipeCardViewModel]> = BehaviorRelay<[SwipeCardViewModel]>(value: [])
    
    init(getCardsUseCase: GetOnlineCardsUseCase, saveCardUseCase: SaveCardUseCase, disposeBag: DisposeBag) {
        self.getCardsUseCase = getCardsUseCase
        self.saveCardUseCase = saveCardUseCase
        self.disposeBag = disposeBag
        getCards()
    }
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var info: Driver<String?> {
        return _info.asDriver()
    }
    
    var swipeCardViewModelList: Driver<[SwipeCardViewModel]> {
        return _swipeCardViewModelList.asDriver()
    }
    
    var numberOfCards: Int {
        return _swipeCardViewModelList.value.count
    }
    
    func viewModelForCard(at index: Int) -> SwipeCardViewModel? {
        guard index < _swipeCardViewModelList.value.count else {
            return nil
        }
        
        return SwipeCardViewModel(personObject: _swipeCardViewModelList.value[index].personObject)
    }
    
    
    func getCards() {
        self._isFetching.accept(true)
        getCardsUseCase.excute(result: "50") { (result) in
            
            switch result {
            case .success(let people):
                let swipeCardViewModelList = people.map({SwipeCardViewModel(personObject: $0)})
                self._swipeCardViewModelList.accept(swipeCardViewModelList)
                self._info.accept("")
            
            case .failure(let error):
                self._swipeCardViewModelList.accept([])
                self._info.accept("There was something wrong with the request! Error:" + "\n" + error.localizedDescription)
            }
            self._isFetching.accept(false)
        }
    }
    
    func saveCard(personObject: PersonObject!) {
        let isSavedCardSuccessfully: Bool! = saveCardUseCase.saveCard(card: personObject)
        if isSavedCardSuccessfully {
            print("SAVE CARD SUCCESSFULLY")
        } else {
            print("CANNOT SAVE CARD")
        }
    }
}
