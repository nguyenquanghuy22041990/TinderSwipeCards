//
//  PersonModel.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/22/20.
//

import Foundation
import RealmSwift


extension PersonObject: Entity {
    private var personModel: PersonModel {
        let realmPerson = PersonModel()
        realmPerson.fullName = fullName
        realmPerson.birthday = birthday
        realmPerson.address = address
        realmPerson.phoneNumber = phoneNumber
        realmPerson.password = password
        realmPerson.picturePath = picturePath
        
        return realmPerson
    }
    
    func toStorable() -> PersonModel {
        return personModel
    }
}

class PersonModel: Object, Storable {
    
    @objc dynamic var fullName = ""
    @objc dynamic var birthday = ""
    @objc dynamic var address = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var password = ""
    @objc dynamic var picturePath = ""
    
    var uuid: String = UUID().uuidString
    
    var model: PersonObject {
        get {
            return PersonObject(fullName: fullName, birthday: birthday, address: address, phoneNumber: phoneNumber, password: password, picturePath: picturePath)
        }
    }
}
