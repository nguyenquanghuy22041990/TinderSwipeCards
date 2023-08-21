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
    private let getCardsUseCase: GetRemoteCardsUseCase
    private let saveCardUseCase: SaveCardUseCase
    private let disposeBag: DisposeBag
    
    let isFetching = BehaviorRelay<Bool>(value: false)
    let info = BehaviorRelay<String?>(value: "")
    let swipeCardViewModelList: BehaviorRelay<[SwipeCardViewModel]> = BehaviorRelay<[SwipeCardViewModel]>(value: [])
    
    init(getCardsUseCase: GetRemoteCardsUseCase, saveCardUseCase: SaveCardUseCase, disposeBag: DisposeBag) {
        self.getCardsUseCase = getCardsUseCase
        self.saveCardUseCase = saveCardUseCase
        self.disposeBag = disposeBag
        Task.init {
            await getCards()
        }
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
    
    func getCards() async {
        self.isFetching.accept(true)
        do {
            let people = try await getCardsUseCase.excute(results: "50")
            let swipeCardViewModelList = people.map({SwipeCardViewModel(personObject: $0)})
            self.swipeCardViewModelList.accept(swipeCardViewModelList)
            self.info.accept("")
            self.isFetching.accept(false)
        } catch {
            self.swipeCardViewModelList.accept([])
            var message = ""
            if error is CustomError && error as! CustomError == CustomError.networkError {
                message = NSLocalizedString("net_work_error_message", comment: "")
            } else {
                message = NSLocalizedString("failed_api_error_message", comment: "") + "\n" + error.localizedDescription
            }
            self.info.accept(message)
            self.isFetching.accept(false)
        }
    }
    
    func saveCard(personObject: PersonObject!) -> Bool {
        return saveCardUseCase.saveCard(card: personObject)
    }
}
