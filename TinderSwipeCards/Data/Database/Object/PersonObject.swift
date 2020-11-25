//
//  PersonObject.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/24/20.
//

import Foundation

struct PersonObject {
    var fullName: String
    var birthday: String
    var address: String
    var phoneNumber: String
    var password: String
    var picturePath: String

    init(person: Person) {
        self.fullName = person.getFullName()
        self.birthday = person.getBirthdayString()
        self.address = person.getAddress()
        self.phoneNumber = person.getPhoneNumber()
        self.password = person.getPassword()
        self.picturePath = person.getPicture()
    }
    
    init(person: PersonModel) {
        self.fullName = person.fullName
        self.birthday = person.birthday
        self.address = person.address
        self.phoneNumber = person.phoneNumber
        self.password = person.password
        self.picturePath = person.picturePath
    }
    
    init(fullName: String, birthday: String, address: String, phoneNumber: String, password: String, picturePath: String) {
        self.fullName = fullName
        self.birthday = birthday
        self.address = address
        self.phoneNumber = phoneNumber
        self.password = password
        self.picturePath = picturePath
    }
}
