//
//  SwipeCardViewModel.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import UIKit
import RxSwift
import RxCocoa

final class SwipeCardViewModel {
    
    let personObject: PersonObject
    let didSelectNameButton = BehaviorRelay<Bool>(value: true)
    let didSelectDobButton = BehaviorRelay<Bool>(value: false)
    let didSelectAddressButton = BehaviorRelay<Bool>(value: false)
    let didSelectPhoneButton = BehaviorRelay<Bool>(value: false)
    let didSelectPasswordButton = BehaviorRelay<Bool>(value: false)
    
    init(personObject: PersonObject) {
        self.personObject = personObject
    }
    
    var isNameButtonSelected: Observable<Bool> {
        return Observable.combineLatest(didSelectNameButton, didSelectDobButton, didSelectAddressButton, didSelectPhoneButton, didSelectPasswordButton) {
                    if $0, !$1, !$2, !$3, !$4 {
                        return $0
                    }
                    return false
                }
    }
    
    var isDobButtonSelected: Observable<Bool> {
        return Observable.combineLatest(didSelectNameButton, didSelectDobButton, didSelectAddressButton, didSelectPhoneButton, didSelectPasswordButton) {
                    if !$0, $1, !$2, !$3, !$4 {
                        return $1
                    }
                    return false
                }
    }
    
    var isAddressButtonSelected: Observable<Bool> {
        return Observable.combineLatest(didSelectNameButton, didSelectDobButton, didSelectAddressButton, didSelectPhoneButton, didSelectPasswordButton) {
                    if !$0, !$1, $2, !$3, !$4 {
                        return $2
                    }
                    return false
                }
    }
    
    var isPhoneButtonSelected: Observable<Bool> {
        return Observable.combineLatest(didSelectNameButton, didSelectDobButton, didSelectAddressButton, didSelectPhoneButton, didSelectPasswordButton) {
                    if !$0, !$1, !$2, $3, !$4 {
                        return $3
                    }
                    return false
                }
    }
    
    var isPasswordButtonSelected: Observable<Bool> {
        return Observable.combineLatest(didSelectNameButton, didSelectDobButton, didSelectAddressButton, didSelectPhoneButton, didSelectPasswordButton) {
                    if !$0, !$1, !$2, !$3, $4 {
                        return $4
                    }
                    return false
                }
    }
}
