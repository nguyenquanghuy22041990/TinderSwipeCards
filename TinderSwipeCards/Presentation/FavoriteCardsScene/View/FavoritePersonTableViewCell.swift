//
//  FavoritePersonTableViewCell.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class FavoritePersonTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var disposeBag: DisposeBag? = nil
    var favoriteCardViewModel: FavoriteCardViewModel!
    
    func setUpCell(favoriteCardViewModel: FavoriteCardViewModel!, disposeBag: DisposeBag!) {
        self.disposeBag = disposeBag
        self.favoriteCardViewModel = favoriteCardViewModel
        profileImageView.kf.setImage(with: URL(string: favoriteCardViewModel.personObject.picturePath))
        nameLabel.text = favoriteCardViewModel.personObject.fullName
    }
}
