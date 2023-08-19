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
    
    let isFetching = BehaviorRelay<Bool>(value: false)
    let info = BehaviorRelay<String?>(value: "")
    let swipeCardViewModelList: BehaviorRelay<[SwipeCardViewModel]> = BehaviorRelay<[SwipeCardViewModel]>(value: [])
    
    init(getCardsUseCase: GetOnlineCardsUseCase, saveCardUseCase: SaveCardUseCase, disposeBag: DisposeBag) {
        self.getCardsUseCase = getCardsUseCase
        self.saveCardUseCase = saveCardUseCase
        self.disposeBag = disposeBag
        getCards()
    }
    
    var numberOfCards: Int {
        return swipeCardViewModelList.value.count
    }
    
    func viewModelForCard(at index: Int) -> SwipeCardViewModel? {
        guard index < swipeCardViewModelList.value.count else {
            return nil
        }
        
        return SwipeCardViewModel(personObject: swipeCardViewModelList.value[index].personObject)
    }
    
    func getCards() {
        self.isFetching.accept(true)
        getCardsUseCase.excute(results: "50") { (result) in
            
            switch result {
            case .success(let people):
                let swipeCardViewModelList = people.map({SwipeCardViewModel(personObject: $0)})
                self.swipeCardViewModelList.accept(swipeCardViewModelList)
                self.info.accept("")
            
            case .failure(let error):
                self.swipeCardViewModelList.accept([])
                
                var message = ""
                if error is CustomError && error as! CustomError == CustomError.networkError {
                    message = NSLocalizedString("net_work_error_message", comment: "")
                } else {
                    message = NSLocalizedString("failed_api_error_message", comment: "") + "\n" + error.localizedDescription
                }
                self.info.accept(message)
            }
            self.isFetching.accept(false)
        }
    }
    
    func saveCard(personObject: PersonObject!) -> Bool {
        return saveCardUseCase.saveCard(card: personObject)
    }
}
