//
//  FavoriteCardsViewController.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class FavoriteCardsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var getCardsUseCase: GetLocalFavoriteCardsUseCase! = nil
    var disposeBag: DisposeBag! = DisposeBag()
    private var showFavoriteCardsViewModel: ShowFavoriteCardsViewModel! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showFavoriteCardsViewModel = ShowFavoriteCardsViewModel(getCardsUseCase: getCardsUseCase, disposeBag: disposeBag)
        
        
    }
    
    func setUpBinding() {
        showFavoriteCardsViewModel.favoriteCardViewModelList.drive(onNext: { [unowned self](_) in
            self.tableView.reloadData()
        }, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        showFavoriteCardsViewModel.isFetching.drive(onNext: { (isFetching) in
            if (isFetching) {
                ProgressHUD.show("Get cards...")
            } else {
                ProgressHUD.dismiss()
            }
        }, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
    }

    @IBAction func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteCardsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showFavoriteCardsViewModel.numberOfFavoriteCards
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritePersonTableViewCell", for: indexPath) as! FavoritePersonTableViewCell
        
        let favoriteCardViewModel = showFavoriteCardsViewModel.viewModelForCard(at: indexPath.row)
        cell.setUpCell(favoriteCardViewModel: favoriteCardViewModel, disposeBag: self.disposeBag)
        return cell
    }
    
    
}