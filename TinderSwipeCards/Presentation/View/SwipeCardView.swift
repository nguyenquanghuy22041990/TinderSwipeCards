//
//  SwipeCardView.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class SwipeCardView: SwipeableCardViewCard {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var dobButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var passwordButton: UIButton!
    
    
    private var disposeBag: DisposeBag? = nil
    var swipeCardViewModel: SwipeCardViewModel!
    
    // Shadow View
    private weak var shadowView: UIView?
    
    /// Inner Margin
    private static let kInnerMargin: CGFloat = 20.0
    
    override func awakeFromNib() {
        superview?.awakeFromNib()
    
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        configureShadow()
    }
    
    func setUpView(swipeCardViewModel: SwipeCardViewModel!, disposeBag: DisposeBag!) {
        self.swipeCardViewModel = swipeCardViewModel
        self.disposeBag = disposeBag
        profileImageView.kf.setImage(with: URL(string: swipeCardViewModel.personObject.picturePath))
        
        nameButton.rx.tap.subscribe { () in
            self.swipeCardViewModel.didSelectNameButton.accept(!self.swipeCardViewModel.didSelectNameButton.value)
            self.swipeCardViewModel.didSelectDobButton.accept(false)
            self.swipeCardViewModel.didSelectAddressButton.accept(false)
            self.swipeCardViewModel.didSelectPhoneButton.accept(false)
            self.swipeCardViewModel.didSelectPasswordButton.accept(false)
        } onError: { (error) in
            
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposeBag)
        
        
        dobButton.rx.tap.subscribe { () in
            self.swipeCardViewModel.didSelectNameButton.accept(false)
            self.swipeCardViewModel.didSelectDobButton.accept(!self.swipeCardViewModel.didSelectDobButton.value)
            self.swipeCardViewModel.didSelectAddressButton.accept(false)
            self.swipeCardViewModel.didSelectPhoneButton.accept(false)
            self.swipeCardViewModel.didSelectPasswordButton.accept(false)
        } onError: { (error) in
            
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposeBag)

        
        addressButton.rx.tap.subscribe { () in
            self.swipeCardViewModel.didSelectNameButton.accept(false)
            self.swipeCardViewModel.didSelectDobButton.accept(false)
            self.swipeCardViewModel.didSelectAddressButton.accept(!self.swipeCardViewModel.didSelectAddressButton.value)
            self.swipeCardViewModel.didSelectPhoneButton.accept(false)
            self.swipeCardViewModel.didSelectPasswordButton.accept(false)
        } onError: { (error) in
            
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposeBag)
        
        
        phoneButton.rx.tap.subscribe { () in
            self.swipeCardViewModel.didSelectNameButton.accept(false)
            self.swipeCardViewModel.didSelectDobButton.accept(false)
            self.swipeCardViewModel.didSelectAddressButton.accept(false)
            self.swipeCardViewModel.didSelectPhoneButton.accept(!self.swipeCardViewModel.didSelectPhoneButton.value)
            self.swipeCardViewModel.didSelectPasswordButton.accept(false)
        } onError: { (error) in
            
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposeBag)
        
        passwordButton.rx.tap.subscribe(onNext: {
            self.swipeCardViewModel.didSelectNameButton.accept(false)
            self.swipeCardViewModel.didSelectDobButton.accept(false)
            self.swipeCardViewModel.didSelectAddressButton.accept(false)
            self.swipeCardViewModel.didSelectPhoneButton.accept(false)
            self.swipeCardViewModel.didSelectPasswordButton.accept(!self.swipeCardViewModel.didSelectPasswordButton.value)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

        
        /// Bind buttons state
        self.swipeCardViewModel.isNameButtonEnabled.subscribe(onNext: { (isEnable) in
            self.nameButton.isSelected = isEnable
            self.nameButton.tintColor = isEnable ? UIColor.green : UIColor.lightGray
            if isEnable {
                self.titleLabel.text = "My name is"
                self.contentLabel.text = swipeCardViewModel.personObject.fullName
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        self.swipeCardViewModel.isDobButtonEnabled.subscribe(onNext: { (isEnable) in
            self.dobButton.isSelected = isEnable
            self.dobButton.tintColor = isEnable ? UIColor.green : UIColor.lightGray
            if isEnable {
                self.titleLabel.text = "My birthday is"
                self.contentLabel.text = swipeCardViewModel.personObject.birthday
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        self.swipeCardViewModel.isAddressButtonEnabled.subscribe(onNext: { (isEnable) in
            self.addressButton.isSelected = isEnable
            self.addressButton.tintColor = isEnable ? UIColor.green : UIColor.lightGray
            if isEnable {
                self.titleLabel.text = "My address is"
                self.contentLabel.text = swipeCardViewModel.personObject.address
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        self.swipeCardViewModel.isPhoneButtonEnabled.subscribe(onNext: { (isEnable) in
            self.phoneButton.isSelected = isEnable
            self.phoneButton.tintColor = isEnable ? UIColor.green : UIColor.lightGray
            if isEnable {
                self.titleLabel.text = "My phone number is"
                self.contentLabel.text = swipeCardViewModel.personObject.phoneNumber
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        self.swipeCardViewModel.isPasswordButtonEnabled.subscribe(onNext: { (isEnable) in
            self.passwordButton.isSelected = isEnable
            self.passwordButton.tintColor = isEnable ? UIColor.green : UIColor.lightGray
            if isEnable {
                self.titleLabel.text = "My password is"
                self.contentLabel.text = swipeCardViewModel.personObject.password
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

    }
    
    // MARK: - SHADOW
    
    private func configureShadow() {
        // Shadow View
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: SwipeCardView.kInnerMargin,
                                              y: SwipeCardView.kInnerMargin,
                                              width: bounds.width - (2 * SwipeCardView.kInnerMargin),
                                              height: bounds.height - (2 * SwipeCardView.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView

        self.applyShadow(width: CGFloat(0.0), height: CGFloat(0.0))
    }

    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 8.0
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.15
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
    }
}
