//
//  Person.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Mapper

struct Person: Mappable {
    let name: Name?
    let dob: Dob?
    let location: Location?
    let cell: String?
    let login: Login?
    let picture: Picture?
    
    init(map: Mapper) throws {
        name = map.optionalFrom("name")
        dob = map.optionalFrom("dob")
        location = map.optionalFrom("location")
        cell = map.optionalFrom("cell")
        login = map.optionalFrom("login")
        picture = map.optionalFrom("picture")
    }
    
    func getFullName() -> String! {
        var fullName: String! = (name?.title ?? "") + " " + (name?.first ?? "")
        fullName = fullName + " " + (name?.last ?? "")
        return  fullName
    }
    
    func getBirthdayString() -> String! {

        let birthdayString = dob?.date
        let index = (birthdayString?.index(birthdayString!.startIndex, offsetBy: 9))!
        let subBirthdayStr = birthdayString![...index].description
    
        return subBirthdayStr
    }
    
    func getAddress() ->String! {
        return (location?.street?.number?.description ?? "") + " " + (location?.street?.name ?? "")
    }
    
    func getPhoneNumber() -> String! {
        return cell ?? ""
    }
    
    func getPassword() -> String! {
        return login?.password ?? ""
    }
    
    func getPicture() -> String! {
        return picture?.large ?? ""
    }
}
