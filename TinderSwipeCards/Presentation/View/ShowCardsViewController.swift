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
import Koloda

class ShowCardsViewController: UIViewController {
    
    @IBOutlet weak var customKodaCardView: KolodaView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!

    var getCardsUseCase: GetOnlineCardsUseCase!
    var saveCardUseCase: SaveCardUseCase!
    var disposeBag: DisposeBag! = DisposeBag()
    private var showCardsViewModel: ShowCardsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        showCardsViewModel = ShowCardsViewModel(getCardsUseCase: getCardsUseCase, saveCardUseCase: saveCardUseCase, disposeBag: disposeBag)
        
        setUpBinding()
        
        customKodaCardView.dataSource = self
        customKodaCardView.delegate = self
        customKodaCardView.alphaValueOpaque = 1.0
        customKodaCardView.alphaValueTransparent = 1.0
        customKodaCardView.alpha = 1.0
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController: FavoriteCardsViewController = segue.destination as! FavoriteCardsViewController
        
        let localFavoriteCardsRepository: LocalFavoriteCardsRepository = LocalFavoriteCardsRepository(personRepository: GeneralRepository.sharedInstance.personRepository)
        destinationViewController.getCardsUseCase = DefaultGetLocalFavoriteCardsUseCase(getCardsRepository: localFavoriteCardsRepository)
    }
    
    func setUpBinding() {
        self.showCardsViewModel.swipeCardViewModelList.subscribe(onNext: { (_) in
            self.customKodaCardView.resetCurrentCardIndex()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        self.showCardsViewModel.info.subscribe(onNext: { [unowned self](infoString) in
            if (infoString != "") {
                let errorAlertController = AlertWrapper.getErrorAlertController(message: infoString)
                self.present(errorAlertController, animated: true, completion: nil)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

        self.showCardsViewModel.isFetching.subscribe(onNext: { (isFetching) in
            if (isFetching) {
                ProgressHUD.show(NSLocalizedString("getting_cards_message", comment: ""))
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

// MARK: - KolodaViewDataSource

extension ShowCardsViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return showCardsViewModel.numberOfCards
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let cardView = UINib(nibName: "SwipeCardView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwipeCardView
        cardView.setUpView(swipeCardViewModel: showCardsViewModel.viewModelForCard(at: index), disposeBag: self.disposeBag)
        return cardView
    }
}

// MARK: - KolodaViewDelegate

extension ShowCardsViewController: KolodaViewDelegate {
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if (direction == .right || direction == .bottomRight || direction == .topRight) {
                    _ = showCardsViewModel.saveCard(personObject: showCardsViewModel.viewModelForCard(at: index)!.personObject)
        }
    }
}


