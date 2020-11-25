//
//  ShowCardsViewController.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/20/20.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class ShowCardsViewController: UIViewController {
    
    @IBOutlet weak var swipeableCardView: SwipeableCardViewContainer!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!

    var getCardsUseCase: GetOnlineCardsUseCase! = nil
    var saveCardUseCase: SaveCardUseCase! = nil
    var disposeBag: DisposeBag! = DisposeBag()
    private var showCardsViewModel: ShowCardsViewModel! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        showCardsViewModel = ShowCardsViewModel(getCardsUseCase: getCardsUseCase, saveCardUseCase: saveCardUseCase, disposeBag: disposeBag)
        
        setUpBinding()
        
        swipeableCardView.dataSource = self
        swipeableCardView.delegate = self
        
    }
    
    func setUpBinding() {
        self.showCardsViewModel.swipeCardViewModelList.subscribe(onNext: { (_) in
            self.swipeableCardView.reloadData()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        self.showCardsViewModel.info.subscribe(onNext: { [unowned self](infoString) in
            if (infoString != "") {
                let errorAlertController = AlertWrapper.getErrorAlertController(message: infoString)
                self.present(errorAlertController, animated: true, completion: nil)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

        self.showCardsViewModel.isFetching.subscribe(onNext: { (isFetching) in
            if (isFetching) {
                ProgressHUD.show("Get cards...")
            } else {
                ProgressHUD.dismiss()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

        reloadButton.rx.tap.asDriver().drive(onNext: { [unowned self](_) in
            self.showCardsViewModel.getCards()
        }, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
    }
}

// MARK: - SwipeableCardViewDataSource

extension ShowCardsViewController : SwipeableCardViewDataSource {

    func numberOfCards() -> Int {
        return showCardsViewModel.numberOfCards
    }

    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {

        let cardView = SwipeCardView()
        cardView.setUpView(swipeCardViewModel: showCardsViewModel.viewModelForCard(at: index), disposeBag: self.disposeBag)
        return cardView
    }

    func viewForEmptyCards() -> UIView? {
        return nil
    }
}

extension ShowCardsViewController : SwipeableCardViewDelegate {

    func didSwipe(card: SwipeableCardViewCard, direction: SwipeDirection, atIndex index: Int) {
        print("Swiped Card \(index) to the \(direction)")
        
        if (direction == .right || direction == .bottomRight || direction == .topRight) {
            _ = showCardsViewModel.saveCard(personObject: showCardsViewModel.viewModelForCard(at: index)!.personObject)
        }
    }
    
    func didSelect(card: SwipeableCardViewCard, atIndex index: Int) {
        print("Selected Card \(index)")
    }

}

