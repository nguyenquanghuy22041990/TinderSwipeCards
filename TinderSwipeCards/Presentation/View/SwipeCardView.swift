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

    @IBOutlet weak var roundedProfileView: UIView!
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
    
  private var shadowLayer: CAShapeLayer?

  override init(frame: CGRect) {
    super.init(frame: frame)
    shadowLayer = createAndAddShadowLayer(background: .white, shadowWid: 20, shadowHei: 30)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    override func awakeFromNib() {
        superview?.awakeFromNib()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

//        configureShadow()
      shadowLayer?.path = UIBezierPath(roundedRect: bounds, cornerRadius: shadowLayer?.cornerRadius ?? 5).cgPath
      shadowLayer?.shadowPath = shadowLayer?.path

        roundedProfileView.layer.borderWidth = 1.0
        roundedProfileView.layer.borderColor = UIColor.gray.cgColor
    }

  func createAndAddShadowLayer(background: UIColor,
                               shadowRadius: CGFloat = 8,
                               shadowColor: UIColor = UIColor(white: 0, alpha: 0.1), cornerRadius: CGFloat = 5, shadowWid: CGFloat, shadowHei: CGFloat) -> CAShapeLayer {
    let shadowLayer = CAShapeLayer()
    shadowLayer.fillColor = background.cgColor
    shadowLayer.shadowColor = shadowColor.cgColor
    shadowLayer.shadowOffset = CGSize(width: shadowWid, height: shadowHei)
    shadowLayer.shadowOpacity = 1
    shadowLayer.shadowRadius = shadowRadius
    shadowLayer.cornerRadius = cornerRadius
    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    shadowLayer.shadowPath = shadowLayer.path
    self.layer.insertSublayer(shadowLayer, at: 0)

    return shadowLayer
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
        self.swipeCardViewModel.isNameButtonSelected.subscribe(onNext: { (isEnable) in
            self.nameButton.isSelected = isEnable
            self.nameButton.tintColor = isEnable ? UIColor.green : UIColor.lightGray
            if isEnable {
                self.titleLabel.text = "My name is"
                self.contentLabel.text = swipeCardViewModel.personObject.fullName
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        self.swipeCardViewModel.isDobButtonSelected.subscribe(onNext: { (isEnable) in
            self.dobButton.isSelected = isEnable
            self.dobButton.tintColor = isEnable ? UIColor.green : UIColor.lightGray
            if isEnable {
                self.titleLabel.text = "My birthday is"
                self.contentLabel.text = swipeCardViewModel.personObject.birthday
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        self.swipeCardViewModel.isAddressButtonSelected.subscribe(onNext: { (isEnable) in
            self.addressButton.isSelected = isEnable
            self.addressButton.tintColor = isEnable ? UIColor.green : UIColor.lightGray
            if isEnable {
                self.titleLabel.text = "My address is"
                self.contentLabel.text = swipeCardViewModel.personObject.address
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        self.swipeCardViewModel.isPhoneButtonSelected.subscribe(onNext: { (isEnable) in
            self.phoneButton.isSelected = isEnable
            self.phoneButton.tintColor = isEnable ? UIColor.green : UIColor.lightGray
            if isEnable {
                self.titleLabel.text = "My phone number is"
                self.contentLabel.text = swipeCardViewModel.personObject.phoneNumber
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        self.swipeCardViewModel.isPasswordButtonSelected.subscribe(onNext: { (isEnable) in
            self.passwordButton.isSelected = isEnable
            self.passwordButton.tintColor = isEnable ? UIColor.green : UIColor.lightGray
            if isEnable {
                self.titleLabel.text = "My password is"
                self.contentLabel.text = swipeCardViewModel.personObject.password
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

    }
}
